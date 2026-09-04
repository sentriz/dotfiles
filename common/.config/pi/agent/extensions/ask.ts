import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "ask",
    label: "Ask",
    description:
      "Ask the user a question and wait for their answer. Provide options for a multiple choice question, otherwise the user types a free-form answer.",
    promptSnippet: "Ask the user a question and wait for their answer",
    promptGuidelines: [
      "Only use ask when the user explicitly asks you to, or when a decision is genuinely ambiguous and guessing wrong would waste real work. It is rare - default to deciding yourself and carrying on.",
      "Never use ask to confirm, check in, offer next steps, or pick between things you could just work out.",
      "Never restate an ask question or its options in prose before calling ask - the dialog shows them. Write only the context the options don't carry, then call ask.",
      "ask already appends an 'Other...' choice for free-form answers, so don't add your own escape-hatch option.",
    ],
    parameters: Type.Object({
      question: Type.String(),
      options: Type.Optional(Type.Array(Type.String())),
    }),
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      if (!ctx.hasUI) {
        return { content: [{ type: "text", text: "No UI available to ask the user." }] };
      }

      let answer: string | undefined;
      if (params.options?.length) {
        const other = "Other...";
        answer = await ctx.ui.select(params.question, [...params.options, other], { signal });
        if (answer === other) answer = await ctx.ui.input(params.question, "your answer", { signal });
      } else {
        answer = await ctx.ui.input(params.question, "your answer", { signal });
      }

      return {
        content: [{ type: "text", text: answer ? `User answered: ${answer}` : "User dismissed the question." }],
        details: { question: params.question, answer },
      };
    },
  });
}
