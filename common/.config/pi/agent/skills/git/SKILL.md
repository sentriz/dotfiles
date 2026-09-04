---
name: git
description: Use for any git work - staging, committing, branching, opening, or writing a PR
---

## Staging

Stage the files you worked on by name, or `git add -u` when that covers it. Never `git add -A` or `git add .`.

## Commit messages

Check `git log --oneline -10` for the project's style, then:

- Plain capitalised imperative subject: `Add thing`, `Fix thingy`. No `fix: ` / `feat: ` prefixes
- Only exception: if the log mostly uses conventional commits WITH a scope (`fix(scanner):`, `refactor(db):`), match that exactly. Scopeless prefixes don't count - use the plain style
- Only add a body if the change genuinely needs explaining - most don't
- No `Co-Authored-By` trailer
- Pass the message via HEREDOC so multiline survives

## PRs

Don't open a PR unless explicitly asked. The commit message doubles as the PR body: no "What"/"Why"/"How" headings or templates, just a concise plain-English explanation. GitHub pre-fills it from the commit - usually just keep that.
