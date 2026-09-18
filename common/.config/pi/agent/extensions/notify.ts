import { closeSync, openSync, writeSync } from "node:fs";
import { basename } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	const id = `pi-${process.pid}`;

	let pending: [string, string] | undefined;
	let timer: ReturnType<typeof setTimeout> | undefined;

	const emit = (title: string, body: string) => {
		const chunk = (d: number, p: string, text: string) => {
			const payload = Buffer.from(text).toString("base64");
			return `\x1b]99;i=${id}:d=${d}:p=${p}:e=1;${payload}\x1b\\`;
		};
		try {
			const fd = openSync("/dev/tty", "w");
			writeSync(fd, chunk(0, "title", title) + chunk(1, "body", body));
			closeSync(fd);
		} catch {}
	};

	// TODO: drop the throttle once https://codeberg.org/dnkl/foot/issues/2472 is fixed: foot can only
	// replace a notification whose daemon id the helper has already printed, so back-to-back updates duplicate.
	const notify = (dir: string, body: string) => {
		pending = [`pi ${dir}`, oneLine(body)];
		if (timer) return;
		timer = setTimeout(() => {
			timer = undefined;
			if (pending) {
				const [t, b] = pending;
				pending = undefined;
				emit(t, b);
			}
		}, 500);
	};

	pi.on("tool_call", async (event, ctx) => {
		notify(basename(ctx.cwd), `${event.toolName}: ${summarise(event.input)}`);
	});

	pi.on("message_end", async (event, ctx) => {
		if (event.message.role !== "assistant") return;
		const text = event.message.content
			.filter((c) => c.type === "text")
			.map((c) => c.text)
			.join("\n")
			.trim();
		if (text) notify(basename(ctx.cwd), text);
	});
}

function oneLine(body: string, width = 48): string {
	const line = body.replace(/\s+/g, " ").trim();
	return line.length > width ? `${line.slice(0, width - 1)}…` : line;
}

function summarise(input: unknown): string {
	if (!input || typeof input !== "object") return "";
	const values = Object.values(input as Record<string, unknown>).filter((v) => typeof v === "string");
	return values.join(" ").replace(/\s+/g, " ");
}
