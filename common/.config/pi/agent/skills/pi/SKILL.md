---
name: pi
description: Use when working on pi itself - its config, agents, skills, MCP setup, or the bwrap wrapper
---

- pi is installed at `/usr/lib/pi-coding-agent` (docs in `/usr/lib/pi-coding-agent/docs`); the binary is bun-compiled with the JS embedded, so grepping it for strings is futile - search the docs
- `which pi` is a `bwrap` wrapper that binds `$XDG_CONFIG_HOME/pi` and sets `PI_CODING_AGENT_DIR`
- If something fails because of the `bwrap` sandbox (missing path, read-only mount, denied access, etc) and a small wrapper tweak would fix it for good, stop and ask me to adjust the sandbox rather than working around it.
