import { writeSync, openSync, closeSync } from "node:fs";
import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.on("agent_settled", async (_event, ctx) => {
		let text = "done working";
		for (const e of ctx.sessionManager.getBranch()) {
			if (e.type === "message" && e.message.role === "assistant") {
				const m = e.message as AssistantMessage;
				const parts = m.content.filter((c) => c.type === "text").map((c) => c.text);
				if (parts.length) text = parts.join("\n");
			}
		}

		const clean = (s: string) => s.replace(/[\x00-\x1f;]/g, " ");
		try {
			const fd = openSync("/dev/tty", "w");
			writeSync(fd, `\x1b]777;notify;pi;${clean(text)}\x1b\\`);
			closeSync(fd);
		} catch {}
	});
}
