import { writeSync, openSync, closeSync } from "node:fs";
import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.registerCommand("copy-code", {
		description: "Copy all code blocks and quotes from the last assistant message",
		handler: async (_args, ctx) => {
			let text = "";
			for (const e of ctx.sessionManager.getBranch()) {
				if (e.type === "message" && e.message.role === "assistant") {
					const m = e.message as AssistantMessage;
					const parts = m.content.filter((c) => c.type === "text").map((c) => c.text);
					if (parts.length) text = parts.join("\n");
				}
			}

			const quoted = [...text.matchAll(/(?:^[ \t]*>[^\n]*\n?)+/gm)].map((m) => ({
				index: m.index,
				end: m.index + m[0].length,
				text: m[0]
					.split("\n")
					.map((l) => l.replace(/^[ \t]*> ?/, ""))
					.join("\n")
					.trim(),
			}));
			const fenced = [...text.matchAll(/```[^\n]*\n([\s\S]*?)```/g)]
				.filter((m) => !quoted.some((q) => m.index >= q.index && m.index < q.end))
				.map((m) => ({
					index: m.index,
					text: m[1],
				}));

			const blocks = [...fenced, ...quoted].sort((a, b) => a.index - b.index);
			if (!blocks.length) {
				ctx.ui.notify("No code block or quote found", "warning");
				return;
			}
			const code = blocks.map((b) => b.text).join("\n\n");

			try {
				const fd = openSync("/dev/tty", "w");
				writeSync(fd, `\x1b]52;c;${Buffer.from(code).toString("base64")}\x1b\\`);
				closeSync(fd);
				ctx.ui.notify(`Copied ${blocks.length} block${blocks.length === 1 ? "" : "s"}`, "info");
			} catch {
				ctx.ui.notify("Failed to write to /dev/tty", "error");
			}
		},
	});
}
