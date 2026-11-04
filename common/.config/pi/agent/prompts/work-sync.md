---
description: Sync this session's work to the "work" task list
---
Sync what happened in this session to my "work" task list. I view it in Planify; pimsync keeps `$CALENDARS_DIR` in sync with it.

Read the list with `todo --porcelain list work --status ANY`, and `todo path <id>` for a task's `.ics` file. Never write with `todo`: edit the `.ics` files directly.

For each piece of work from this session:
- If a task already covers it, rewrite its `DESCRIPTION`. If the work is finished, set `STATUS:COMPLETED` and add `COMPLETED:<utc now>`.
- Otherwise add a task: a new `<uuid>.ics` in the same directory, in the same shape as the existing files, with a fresh `UID` and `CREATED`/`DTSTAMP` set to now.

Always bump `DTSTAMP` and add or replace `LAST-MODIFIED` on any file you change. Never delete tasks.

Titles: a few words, the way I write them ("jakob token", "agentic core docs"). No ticket ids or status in the title.

Descriptions: what I need to pick the task back up cold - links (PR, Linear, Slack thread), the branch, the current state, and the next step. A few short lines; escape newlines as `\n` and commas as `\,`.

Sections: they are parent tasks with a `SUMMARY` like `List : mon`, and a task belongs to one via `RELATED-TO:<parent uid>`. Put new tasks in today's weekday section if one exists, matched by prefix, otherwise leave them unsectioned.

Finish with one line per change: `added|updated|done <title>`.
