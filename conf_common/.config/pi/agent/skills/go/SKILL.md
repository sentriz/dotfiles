---
name: go
description: Use when reading, writing or refactoring Go code
---

- Keep the number of functions low. Long functions are fine - less indirection is easier to read. Only extract a function when the work is reused or needs testing; a function should have more than one caller. This keeps the package namespace uncluttered and spares readers wondering "who calls this?" when the answer is one place that could be inlined. A guideline, not a hard rule - keep the philosophy in mind.
- Generally don't write methods. Only write a method if it mutates the struct or is required to satisfy an interface - otherwise make it a normal function.
- Check required env vars explicitly - `os.Getenv` plus an empty check - rather than letting an empty string flow on. For the user config dir use `os.UserConfigDir()`.
- When building a slice in a loop, prefer `make([]T, 0, n)` + `append` over `make([]T, n)` + indexed assignment.
- Prefer `gopls` for LSP-style queries (`references`, `implementation`, `definition`, `call_hierarchy`) over `grep` when the question is "where is X used / defined / implemented" - it understands types, embedding, and interfaces; `grep` doesn't.
- For renames spanning more than one site, use `gopls rename -w <file>:<line>:<col> <newName>` instead of hand-edits. Run `gofmt -w` after if struct field alignment is disturbed.
