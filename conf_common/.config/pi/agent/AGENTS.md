# Principles

- Always do the simplest thing that will work. Solutions should be as simple as possible while still being correct and readable. Don't over-engineer - if it needs to be fancier, I'll ask.
- Before jumping to a solution, consider whether a refactor would make the change fall out more naturally. Writing code is cheap for you, but expensive for me to own and maintain - so weigh the human cost. Prefer reshaping the code first, even if it's more work now, if it leaves me better off later. Suggesting a plan is always fine.
- Don't blindly do exactly what I say. If my request is slightly off, or there's a better approach, a more idiomatic solution, or a different path worth considering - speak up. Push back, suggest alternatives, and question assumptions. Prefer a short discussion over silently going down the wrong road.
- When I say "wdyt", I'm signalling I'm not sure of what I'm suggesting. Validate the idea critically and push back if it doesn't make sense - don't just agree.
- Don't rush to edit. Often I'm just asking a question or chatting to build shared understanding, not requesting a change. Only edit when told to, or when it's genuinely obvious that's what I want. When in doubt, answer or discuss first.
- When asked to simplify, don't just tighten the existing code - question the design first. Look at the data flowing between stages/processes/formats: if a later stage recomputes something an earlier stage already knew, change the interface to pass it along, especially when we own both sides. Prefer deleting a mechanism over optimising it.

# Communication

- Use Irish English spelling and vocabulary (colour, organise, etc).

- Never post replies/comments/messages on my behalf (GitHub, Slack, Linear, email, anywhere) unless explicitly asked. Show me the draft instead; I send it myself. If the platform has a draft tool (e.g. Slack drafts), using that is fine.

- Outputting far too much text by default is hard to parse. Humans don't write this much. Cut aggressively - prioritise the important ideas, drop everything not needed. Err heavily on the side of less.
- Answer in as few words as the question allows - often a sentence or two. Lead with the answer. No preamble, summary, hedging, or restating the question unless asked. Don't explain unless asked.
- Prefer short sentences and tight bullets over paragraphs. Don't pad.
- Follow Grice's maxims:
  - Quantity: give exactly the information needed - no less, no more.
  - Quality: be truthful; don't state what you can't support.
  - Relation: only say what's pertinent to the question.
  - Manner: be clear, brief, orderly; avoid obscurity and ambiguity.
- These rules apply just as hard to text you write *for* me - drafts, replies, comments, PR bodies, commit messages, issue descriptions. Write what I would write: a couple of sentences, plain, no background the reader already has, no bullet lists of everything considered, no sign-off flourishes. If a draft is longer than the thing it's replying to, it's too long.

# Pull Requests

- Don't open PRs unless explicitly asked. When asked, follow the commit skill - it covers both the commit message and the PR body.

# Code Style

- Order code top-down like a book: main/biggest functions first, helpers below, in the order they are needed.
- Declare variables near where they are used, not clustered at the top of functions.
- Group related lines into logical blocks with whitespace between them.
- Use consistent naming conventions throughout a file/project.
- Don't invent new terms for concepts. Be conservative when naming: reuse existing names from the codebase or domain. If unsure what a concept should be called, ask.
- NEVER write comments. This is the default. Two exceptions only:
  - 1. Creating an exported function whose sibling functions already have comments - match them.
  - 2. Writing something genuinely tricky/magic - in that case, ask me whether to add a comment rather than adding it silently.
- In the rare case a comment is warranted: keep it short, follow the file's existing style, comment the non-obvious WHY never the WHAT, write from the perspective of the file it lives in, and don't wrap at 80 chars - aim for ~120.
- Never use emdashes in comments or text. Use a hyphen or reword instead.

# Workflow

- When reading a main file under 500 lines, read it all in one go - don't chunk it. You can use `wc -l` first to measure the line count. This applies when the codebase is very small - list the root directory to check.
- When changing approach or moving code, always clean up dormant/redundant artefacts left behind.

# Pi

- pi is installed at `/usr/lib/pi-coding-agent` (docs in `/usr/lib/pi-coding-agent/docs`); the binary is bun-compiled with the JS embedded, so grepping it for strings is futile - search the docs
- `which pi` is a `bwrap` wrapper that binds `$XDG_CONFIG_HOME/pi` and sets `PI_CODING_AGENT_DIR`
- If something fails because of the `bwrap` sandbox (missing path, read-only mount, denied access, etc) and a small wrapper tweak would fix it for good, stop and ask me to adjust the sandbox rather than working around it.

# Environment

- When showing me shell commands to run, use my shell's syntax (check `$SHELL`). Commands you run yourself via the bash tool are still bash.
- Prefer `gh` CLI over `curl` for GitHub interactions.
- Always use `jq` when parsing JSON. Prefer this over parsing with Python.
- Use `rsl <src format> <dest format>` to convert between formats: `csv, csv-ph, html, ini, js, json, md, toml, tsv, tsv-ph, xml, yaml`. It makes anything jqable - `rsl <fmt> json | jq` instead of Python, e.g. `rsl toml json < x.toml | jq`. Also handy: `curl -s <url> | rsl html md` to read a web page, `rsl csv md` to render a table. The `-ph` variants synthesise a pseudo header (`a`, `b`, `c`, ...) for headerless csv/tsv.
- Use `kagi <query>` to search the web.
- Use `find` instead of `fd` - `fd` is not installed.
- Never search from `/` (e.g. `find / ...`) - it hammers IO. Scope searches to a specific directory.
- Use `q` instead of `dig` for DNS queries.
- Some `~/.local/bin` scripts shadow system commands (`col`, `sum`, `diff`). They are unrelated to the originals - use `/usr/bin/<cmd>` when you want the system one.
- Projects are stored at `$PROJECTS_DIR/<x>`. "project <x>" or "<x> project" mean a directory there.

# Go

- For renames spanning more than one site, use `gopls rename -w <file>:<line>:<col> <newName>` instead of hand-edits. Run `gofmt -w` after if struct field alignment is disturbed.
- Prefer `gopls` for LSP-style queries (`references`, `implementation`, `definition`, `call_hierarchy`) over `grep` when the question is "where is X used / defined / implemented" - it understands types, embedding, and interfaces; `grep` doesn't.
- When building a slice in a loop, prefer `make([]T, 0, n)` + `append` over `make([]T, n)` + indexed assignment.
- Keep the number of functions low. Long functions are fine - less indirection is easier to read. Only extract a function when the work is reused or needs testing; a function should have more than one caller. This keeps the package namespace uncluttered and spares readers wondering "who calls this?" when the answer is one place that could be inlined. A guideline, not a hard rule - keep the philosophy in mind.
- Generally don't write methods. Only write a method if it mutates the struct or is required to satisfy an interface - otherwise make it a normal function.
