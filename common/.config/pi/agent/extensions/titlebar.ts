import path from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	function setTitle(ctx: ExtensionContext) {
		const cwd = path.basename(process.cwd());
		const label = pi.getSessionName() ?? firstUserMessage(ctx);
		ctx.ui.setTitle(label ? `pi ${cwd} ${label}` : `pi ${cwd}`);
	}

	pi.on("session_start", (_event, ctx) => setTimeout(() => setTitle(ctx), 0));
	pi.on("session_info_changed", (_event, ctx) => setTitle(ctx));
	pi.on("agent_settled", (_event, ctx) => setTitle(ctx));
}

function firstUserMessage(ctx: ExtensionContext): string | undefined {
	for (const e of ctx.sessionManager.getBranch()) {
		if (e.type !== "message" || e.message.role !== "user") continue;
		const { content } = e.message;
		const text = typeof content === "string" ? content : content.find((c) => c.type === "text")?.text;
		if (text) return truncate(text.trim().replace(/\s+/g, " "), 60);
	}
	return undefined;
}

function truncate(s: string, n: number): string {
	return s.length > n ? `${s.slice(0, n - 1)}…` : s;
}
