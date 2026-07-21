import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execSync } from "node:child_process";

let section: string | undefined;

function mcpUsage(): string {
  return execSync("mcp usage 2>&1", { encoding: "utf8" }).trim();
}

function buildSection(): string {
  try {
    const servers = execSync("mcp server", { encoding: "utf8" })
      .split("\n")
      .map((s) => s.split("\t")[0].trim())
      .filter(Boolean);

    return [
      "\n\n# MCP",
      `Reach MCP servers through the \`mcp\` CLI tool. Configured servers: ${servers.map((s) => `\`${s}\``).join(", ")}.`,
      "```\n" + mcpUsage() + "\n```",
      "List a server's tools when you need it, discover the tool's schema, then call it. Prefer the key=value argument notation over raw JSON, though JSON is sometimes needed for nested values.",
      "Tools returning images, audio, or file blobs put base64 in a `data` field. Never print it - pipe it straight to a file and read that:",
      "```\nmcp server chrome call take_screenshot | jq -r '.[]|select(.type==\"image\").data' | base64 -d > /tmp/shot.png\n```",
    ].join("\n\n");
  } catch {
    return "";
  }
}

export default function (pi: ExtensionAPI) {
  pi.on("before_agent_start", (event) => {
    section ??= buildSection();
    if (!section) return;
    return { systemPrompt: event.systemPrompt + section };
  });
}
