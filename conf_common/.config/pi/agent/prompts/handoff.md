---
description: Write a handoff brief for another pi session
argument-hint: "<task>"
---
Write a handoff brief so I can delegate work to another pi instance. The other pi has no context from this conversation, so the brief must be fully self-contained.

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
<everything the other pi needs: relevant files with absolute paths, key findings from this conversation, decisions already made, gotchas>

# Constraints
<what not to touch, style requirements, scope limits>

# Done when
<concrete, checkable definition of done>
```

Keep it tight - include everything necessary, nothing more. Do not include instructions for the child to report back; I check on it via its session file.

## Checking up later

When I later ask how this handoff is going:

1. Find the child session: `grep -rl "handoff-id: <id>" $PI_CODING_AGENT_DIR/sessions/`, excluding this session (`$PI_SESSION_FILE`). If multiple match, use the most recently modified.
2. Extract the recent activity. Each line is JSON; message entries look like `{"type":"message","message":{"role":"user|assistant|toolResult","content":...}}` where content is a string or an array of `{type:"text",text}` / `{type:"toolCall",name,arguments}` parts. Use this (adjust tail as needed):

   ```
   stat -c '%y' "$f"; jq -r 'select(.type=="message") | .message.role as $r | (if (.message.content|type)=="string" then [$r+": "+.message.content] else [.message.content[]? | if .type=="text" then $r+": "+.text[0:300] elif .type=="toolCall" then $r+" ["+.name+"] "+(.arguments|tostring|.[0:200]) else empty end] end) | .[]' "$f" | tail -60
   ```
3. Summarize: what the child has done, what it's doing now, whether it looks finished/working/stuck/waiting, and the session mtime as last activity. If nothing matches, the brief probably hasn't been pasted yet.
