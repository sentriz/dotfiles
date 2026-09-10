import type { AssistantMessage, UserMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const marker = "[speak]";

const convention = `When a user message ends with ${marker}, the answer will be heard aloud rather than
read. Write plain spoken prose: no markdown, no code, no file paths, no lists.
Carry structure in words instead - "three steps: first ... then ... last ...".
Lead with the answer, and let the length follow the question: a one-line answer
stays one line, a plan can run for a minute.`;

const summariser = "gpt-5.6-luna";

const rewrite = `Rewrite the following to be heard rather than read, by a listener who cannot see a
screen. Keep every point that matters and stay as long as the material needs.
Drop markdown, code, and file paths, and carry any structure in words instead -
"three steps: first ... then ... last ...". Lead with the answer. Reply with only
the spoken text.`;

export default function (pi: ExtensionAPI) {
	let queue = Promise.resolve();

	const say = (text: string, ctx: ExtensionContext) => {
		queue = queue.then(async () => {
			ctx.ui.setStatus("speak", "speaking...");
			try {
				const fifo = process.env.SPEAK_FIFO!;
				const result = await pi.exec("sh", ["-c", 'exec speak "$1" >"$2"', "sh", text, fifo]);
				if (result.code !== 0) ctx.ui.notify(`speak failed: ${result.stderr}`, "error");
			} finally {
				ctx.ui.setStatus("speak", "");
			}
		});
		return queue;
	};

	pi.registerCommand("speak", {
		description: "Answer out loud, or read the last response out loud",
		handler: async (args, ctx) => {
			const question = args.trim();
			if (question) {
				const message = `${question} ${marker}`;
				if (ctx.isIdle()) pi.sendUserMessage(message);
				else pi.sendUserMessage(message, { deliverAs: "followUp" });
				return;
			}

			const text = lastText(ctx, "assistant");
			if (!text) {
				ctx.ui.notify("nothing to speak", "warn");
				return;
			}

			ctx.ui.setStatus("speak", "summarising...");
			try {
				say(await summarise(text, ctx), ctx);
			} catch (err) {
				ctx.ui.notify(`speak failed: ${err}`, "error");
				ctx.ui.setStatus("speak", "");
			}
		},
	});

	pi.on("before_agent_start", async (event) => ({
		systemPrompt: `${event.systemPrompt}\n\n${convention}`,
	}));

	pi.on("agent_settled", async (_event, ctx) => {
		if (!lastText(ctx, "user").trimEnd().endsWith(marker)) return;
		const text = lastText(ctx, "assistant");
		if (text) say(text, ctx);
	});
}

function lastText(ctx: ExtensionContext, role: "user" | "assistant"): string {
	let text = "";
	for (const e of ctx.sessionManager.getBranch()) {
		if (e.type === "message" && e.message.role === role) {
			const m = e.message as AssistantMessage | UserMessage;
			const parts = m.content.filter((c) => c.type === "text").map((c) => c.text);
			if (parts.length) text = parts.join("\n");
		}
	}
	return text;
}

type SummaryEvent =
	| { type: "done"; message: AssistantMessage }
	| { type: "error"; error: { errorMessage: string } }
	| { type: string };

async function summarise(text: string, ctx: ExtensionContext): Promise<string> {
	const provider = ctx.modelRegistry.getProvider("openai");
	const model = ctx.modelRegistry.find("openai", summariser);
	if (!provider || !model) throw new Error(`${summariser} unavailable`);

	const { auth } = await ctx.modelRegistry.getProviderAuth("openai");
	const context = {
		systemPrompt: rewrite,
		messages: [{ role: "user" as const, content: [{ type: "text" as const, text }] }],
	};

	const stream = provider.stream(model, context, { apiKey: auth.apiKey }) as AsyncIterable<SummaryEvent>;
	for await (const event of stream) {
		if (event.type === "error") throw new Error((event as { error: { errorMessage: string } }).error.errorMessage);
		if (event.type !== "done") continue;
		const message = (event as { message: AssistantMessage }).message;
		return message.content
			.filter((c) => c.type === "text")
			.map((c) => c.text)
			.join("");
	}
	throw new Error("no response");
}
