---
description: Review a session for mistakes and propose fixes to the environment
---
Run a retrospective on this session, or on the sessions in `$PI_CODING_AGENT_DIR/sessions` matching: $@

Find where the agent went wrong: failed or retried tool calls, wrong assumptions, slow searches, and things I had to correct. For each one, find the root cause and propose the cheapest fix that prevents it.

Prefer a mechanical fix (a check, script, or wrapper) over a note. When a note is needed, put it in the narrowest existing file that will be loaded when it's relevant, and rewrite or merge existing lines instead of appending. Flag existing notes that didn't change behaviour for deletion. Skip one-offs.

List the findings, most costly first, each with its fix and destination. Don't edit until I pick.
