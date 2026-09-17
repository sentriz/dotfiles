import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  let previewInput = false;
  let previewOutput = false;

  pi.registerCommand("preview-input", {
    description: "Toggle previewing tool calls before they run",
    async handler(_args, ctx) {
      previewInput = !previewInput;
      ctx.ui.setStatus("preview-input", previewInput ? "preview:in" : undefined);
    },
  });

  pi.registerCommand("preview-output", {
    description: "Toggle previewing tool results before the model sees them",
    async handler(_args, ctx) {
      previewOutput = !previewOutput;
      ctx.ui.setStatus("preview-output", previewOutput ? "preview:out" : undefined);
    },
  });

  pi.on("tool_call", async (event, ctx) => {
    if (!previewInput || !ctx.hasUI) return;

    const choice = await ctx.ui.select(`${event.toolName} call`, ["run", "edit", "reject"], { signal: ctx.signal });
    if (choice !== "run" && choice !== "edit") return { block: true, reason: "User rejected this tool call." };
    if (choice === "run") return;

    const edited = await ctx.ui.editor(`${event.toolName} call`, JSON.stringify(event.input, null, 2), {
      signal: ctx.signal,
    });
    if (edited === undefined) return { block: true, reason: "User rejected this tool call." };

    Object.assign(event.input, JSON.parse(edited));
  });

  pi.on("tool_result", async (event, ctx) => {
    if (!previewOutput || !ctx.hasUI) return;

    const texts = event.content.filter((block) => block.type === "text");
    if (texts.length === 0) return;

    const choice = await ctx.ui.select(`${event.toolName} result`, ["send", "edit", "withhold"], { signal: ctx.signal });
    if (choice === "send") return;
    if (choice !== "edit") return { content: [{ type: "text", text: "User withheld this tool result." }], isError: true };

    const edited = await ctx.ui.editor(`${event.toolName} result`, texts.map((block) => block.text).join("\n"), {
      signal: ctx.signal,
    });
    if (edited === undefined) return { content: [{ type: "text", text: "User withheld this tool result." }], isError: true };

    return { content: [...event.content.filter((block) => block.type !== "text"), { type: "text", text: edited }] };
  });
}
