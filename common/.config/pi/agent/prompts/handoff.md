---
description: Write a handoff brief for another pi session
argument-hint: "<task>"
---
Write a handoff brief so I can delegate work to another pi instance. The other pi has no context from this conversation, but it has the same tools and can read the codebase itself. The brief is for context only known in this session: findings, decisions, intent, and gotchas. Leave out anything the other pi can cheaply find out on its own, like file contents or how code works.

Task to hand off: $@

Steps:
1. Generate a short random handoff id of the form `hx-XXXX` (4 lowercase hex chars, e.g. via `openssl rand -hex 2`).
2. Print the brief inside a single fenced code block so I can copy it with /copy. Nothing else after the code block.

The brief format:

```
handoff-id: hx-XXXX

# Goal
<one paragraph, what needs to be done and why>

# Context
<what only this session knows: key findings, decisions already made, gotchas, and pointers to relevant files with absolute paths>

# Constraints
<what not to touch, style requirements, scope limits>

# Done when
<concrete, checkable definition of done>

# Log
When a concrete decision is settled or a concrete action is completed and I'm happy with it, emit a single line `hx-XXXX <what>` in your reply. This is a log so the parent session can follow progress by grepping for `hx-XXXX`. Err on the side of less: only milestones, not every step.
```

Keep it tight - include everything necessary, nothing more. Do not include any other instructions for the child to report back; I check on it via its session file.

## Checking up later

When I later ask how this handoff is going:

1. Find the child session: `grep -rl "handoff-id: <id>" $PI_CODING_AGENT_DIR/sessions/`, excluding this session (`$PI_SESSION_FILE`). If multiple match, use the most recently modified.
2. Extract the recent activity. Each line is JSON; message entries look like `{"type":"message","message":{"role":"user|assistant|toolResult","content":...}}` where content is a string or an array of `{type:"text",text}` / `{type:"toolCall",name,arguments}` parts. Use this (adjust tail as needed):

   ```
   stat -c '%y' "$f"; jq -r 'select(.type=="message") | .message.role as $r | (if (.message.content|type)=="string" then [$r+": "+.message.content] else [.message.content[]? | if .type=="text" then $r+": "+.text[0:300] elif .type=="toolCall" then $r+" ["+.name+"] "+(.arguments|tostring|.[0:200]) else empty end] end) | .[]' "$f" | tail -60
   ```
3. Get the log lines: `grep -o 'hx-XXXX [^"\\]*' "$f"` (dropping the `handoff-id:` line). Use these as the main history; the tail covers what's happened since.
4. Summarize: what the child has done, what it's doing now, whether it looks finished/working/stuck/waiting, and the session mtime as last activity. If nothing matches, the brief probably hasn't been pasted yet.
