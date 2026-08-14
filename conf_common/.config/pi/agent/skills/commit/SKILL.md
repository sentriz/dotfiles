---
name: commit
description: Use when creating a git commit, or a branch/PR that needs one
---

Create a git commit for the current staged and unstaged changes.

1. Run `git status` (never use `-uall`) and `git diff` (staged + unstaged) and `git log --oneline -10` in parallel
2. Stage the relevant files by name (avoid `git add -A` or `git add .`). Do not commit files that likely contain secrets (.env, credentials, etc)
3. Write a concise commit message:
   - Only add a commit body if the change genuinely needs explaining — most don't
   - Do NOT add a `Co-Authored-By` trailer
   - Default: a plain capitalised imperative subject, e.g. `Add thing`, `Fix thingy`. No `fix: ` / `feat: ` prefixes
   - Only exception: if the project's log mostly uses conventional commits WITH a scope (`fix(scanner):`, `feat(subsonic):`, `refactor(db):`), match that style exactly
   - If the project uses scopeless prefixes (`feat: `, `fix: `), ignore them and use the plain style instead
4. Create the commit. Pass the message via HEREDOC:

   ```
   git commit -m "$(cat <<'EOF'
   message here
   EOF
   )"
   ```

5. Run `git status` to verify

## PR bodies

When the commit is going into a PR, the same message does double duty: no "What"/"Why"/"How" headings or templates, just a concise plain-English explanation of the change - often identical to the commit message body (GitHub pre-fills it from there anyway; usually just keep that).
