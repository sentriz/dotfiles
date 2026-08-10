import { writeSync, openSync, closeSync } from "node:fs";
import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.registerCommand("copy-code", {
		description: "Copy the last code block from the last assistant message",
		handler: async (_args, ctx) => {
			let text = "";
			for (const e of ctx.sessionManager.getBranch()) {
				if (e.type === "message" && e.message.role === "assistant") {
					const m = e.message as AssistantMessage;
					const parts = m.content.filter((c) => c.type === "text").map((c) => c.text);
					if (parts.length) text = parts.join("\n");
				}
			}

			const blocks = [...text.matchAll(/```[^\n]*\n([\s\S]*?)```/g)];
			if (!blocks.length) {
				ctx.ui.notify("No code block found", "warning");
				return;
			}
			const code = blocks[blocks.length - 1][1];

			try {
				const fd = openSync("/dev/tty", "w");
				writeSync(fd, `\x1b]52;c;${Buffer.from(code).toString("base64")}\x1b\\`);
				closeSync(fd);
				ctx.ui.notify("Copied last code block", "info");
			} catch {
				ctx.ui.notify("Failed to write to /dev/tty", "error");
			}
		},
	});
}
