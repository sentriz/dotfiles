import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	let injected = false;

	pi.on("before_agent_start", () => {
		if (injected) return;
		injected = true;
		return {
			message: {
				customType: "date",
				content: `Current date: ${new Date().toDateString()}`,
				display: false,
			},
		};
	});
}
