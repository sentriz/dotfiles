---
description: Drive the current PR to a mergeable state - request review, rebase, watch CI
argument-hint: "[pr number or url]"
---
# Get this PR ready to merge

PR: ${@:-the PR for the current branch (`gh pr view --json number,title,url,baseRefName,isDraft,reviewRequests,reviews`)}

Your job is to get the PR merged: request review, keep it current, watch CI, and let it merge once it's green and approved.

## 1. Request review

Check existing reviewers/reviews first - never re-request from someone already requested or who has reviewed.

If nobody is requested and nobody has reviewed, pick reviewers:

- `CODEOWNERS` for the touched paths, if the repo has one.
- Otherwise the people with the most recent commits in the files this PR touches (`git log --format='%an %ae' -20 -- <paths>`), excluding me.
- Skip bots.

Request them with `gh pr edit --add-reviewer`. If you can't work out a sensible reviewer, or the PR is a draft, ask me instead of guessing.

## 2. Enable auto-merge

`gh pr merge --auto --squash` (fall back to `--merge`/`--rebase` if squash isn't allowed on the repo). That way GitHub merges it the moment checks pass and review requirements are met, without you sitting on it.

If auto-merge isn't available (feature disabled on the repo), skip this and merge yourself in step 3.

## 3. Keep it mergeable, in a loop

While waiting, keep the PR current and watch CI:

- `gh pr checks --watch` to wait on runs. Prefer watching over polling in a sleep loop.
- If the base branch has moved, rebase onto it and force-push (`git fetch origin && git rebase origin/<base> && git push --force-with-lease`). Re-check after each rebase - a rebase restarts CI.
- If a check fails: read the logs (`gh run view --log-failed`), and if the fix is obviously ours and small (lint, formatting, a broken test we caused), fix it, commit, push, and carry on. If it's a flake, re-run it. If it's a real failure needing a design decision, stop and tell me.
- If there are merge conflicts you can't resolve mechanically, stop and tell me.
- Follow the git skill for any commits you make.

Repeat until CI is green *and* the branch is up to date with its base.

## 4. Merge

Once CI is green and the branch is current: if auto-merge is on, it should merge itself - confirm with `gh pr view --json state,mergedAt`. If it hasn't (auto-merge unavailable, or approval isn't required), merge it yourself with the same method, deleting the branch.

If it's blocked only on a human approval, leave auto-merge armed and stop - say who we're waiting on.

Then report in a few lines: merged or why not, and anything I should know. Don't keep polling after that.
