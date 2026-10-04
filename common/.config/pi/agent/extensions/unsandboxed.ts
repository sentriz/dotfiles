import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  if (!process.env.PI_UNSANDBOXED) return;

  pi.on("session_start", (event, ctx) => {
    if (event.reason !== "startup") return;
    if (!ctx.sessionManager.getBranch().some((e) => e.type === "message"))
      return;
    pi.sendUserMessage("I've restarted you with `PI_UNSANDBOXED=1`");
  });
}
