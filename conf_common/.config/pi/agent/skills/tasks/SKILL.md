---
name: tasks
description: Personal task/topic tracker stored in a YAML file. Use when the user asks what's open, where they're needed, to add/close/update a task, or runs a sync to pull updates from email, Slack, Linear, GitHub since the last sync.
---

# tasks

Single source of truth: the tasks file (default `$XDG_DATA_HOME/tasks/tasks.yaml`). Read it first for every command - it also carries the user's own config under `meta`.

To pull out one topic, query it structurally rather than grepping:

```
<$XDG_DATA_HOME/tasks/tasks.yaml rsl yaml json | jq '.topics[] | select(.id == "<id>")'
```

## Schema

```yaml
meta:
  last_sync: <ISO datetime>          # cursor for sync
  me: <name used in owner/ball>      # who "I" am
  sources:                           # what sync checks; see "Sources" below
    - kind: <gmail | slack | linear | github>
      <kind-specific config>

topics:
  - id: <stable-kebab-slug>
    party: <name>                    # optional; customer/client/org this belongs to
    title: <one line>
    owner: <person> | team
    ball: <person> | team | scheduled | none
    status: open | closed
    due: <YYYY-MM-DD>                # optional, only for real deadlines
    planned: true                    # optional; part of committed work (e.g. sprint); absent = unplanned/adhoc
    prio: <1-4>                      # optional; Linear's scale - 1 urgent, 2 high, 3 medium, 4 low; absent = none
    last_me: <YYYY-MM-DD>            # optional; last date the user (`me`) acted on this topic - keep current on sync/edits; omit if never
    last_activity: <YYYY-MM-DD>      # optional; newest REAL movement on the links (Linear updatedAt, PR push/comment, email/Slack message) - set by sync, never bumped by our own log-keeping
    next: <the next concrete step>
    notes: <standing context>        # optional, single string
    links:                           # optional, plain URL list
      - <url>
    prompts:                         # optional; ready-to-use prompts to hand an agent for this topic
      - <prompt>
    log:                             # newest first, "YYYY-MM-DD: what happened"
      - "..."
```

Rules: never delete topics - set `status: closed` (log survives for handback). State changes flip `ball`/`status` and append a log line; don't rewrite history. Keep `next` current - it's the answer to "what do I do here".

Priority: `prio` uses Linear's numbers so it sorts naturally and needs no translation. Where the topic's Linear tickets carry a priority, mirror the most urgent of them (lowest number) and keep it in step on sync. Otherwise - no ticket, or tickets set to No priority - judge it, since most customer work lives outside Linear and an unranked topic just disappears down the sort:

- `1` urgent - customer escalated or blocked right now, deadline today or overdue, something in production is broken
- `2` high - a customer is waiting on us, or a dated commitment depends on it (go-live, training, renewal)
- `3` medium - internal improvement or cleanup, nobody outside is waiting
- `4` low - nice to have, nothing happens if it slips

A value the user set by hand wins until Linear says otherwise. Leave `prio` absent only when the topic is somebody else's to rank.

Staleness: a topic is stale when it is `open`, the `ball` is with us (`me` or `team`), and `last_activity` is more than 30 days old - nothing has moved and nobody external is pushing. Never store a stale flag, it's derived. `last_activity` is deliberately separate from the log, so a sync writing "no movement in 3 months" can't make a topic look alive. Omit it when there's nothing to measure (no links, or commercial topics owned by someone else).

Concurrency: other sessions may be editing the file at the same time. Immediately before every write, re-read the tasks file and apply your changes to that fresh copy - never write from a version read earlier in the conversation. Merge additively (append log lines, update only the fields you have news for); if a topic changed under you, keep the newer state unless your info clearly supersedes it.

## Commands

### open (default, also "what's open", "where am I needed")

Read the file, report only `status: open`, grouped by:
1. **Act now** - `ball: <me>` (or `owner: <me>` + `ball: team`), overdue/today `due` first
2. **Waiting** - ball with someone else
3. **Scheduled** - `ball: scheduled`, sorted by `due`
4. **Watching** - everything else (topics owned by others)

One line per topic: title, party, next step, due if set; mark unplanned topics in Act now (e.g. `[adhoc]`) and stale ones with their age (e.g. `[stale 98d]`). Skip the Watching group unless asked for everything.

Asked what's stale: list only stale topics, oldest first, with the age and what stopped it. These are park-or-do decisions, not work.

### sync

Goal: bring the file up to date with what happened since `meta.last_sync`, including things the user did themselves.

1. Read the tasks file, note `last_sync`, `me` and `sources`.
2. Check every source in `meta.sources` in parallel, following the recipe for its `kind` below. For every `status: open` topic, fetch each URL in `links` via the matching source recipe; ignore links on closed topics. Only check kinds that are listed; if a source's tool isn't available, skip it and say so.
   Parallelise aggressively, within sources too: batch every set of independent calls into one block - the initial searches/lists for all sources together, then all the follow-up reads (gmail threads, slack channels/DMs, linear tickets, gh views) together. Only sequence a call when it needs a result from a previous one. A sync should take a handful of rounds, not one call per item.
3. For each topic with news: append log lines (dated), update `ball`/`next`/`status`. Set `last_activity` on every open topic you checked to the newest movement date you actually saw across its links - especially when that date is old, since that is what makes staleness visible. Set `prio` from the most urgent Linear ticket in `links`. Anything that clearly belongs to no existing topic: propose a new topic, create it if obvious.
4. Run any source's post-sync step (see below).
5. Set `meta.last_sync` to now (`date -Iseconds`).
6. Report a compact diff: topics changed, log lines added, external state adjusted, anything newly needing the user.

Don't invent log entries for sources you couldn't check - say which were skipped and why.

### loop

Run a full sync on a recurring interval (each iteration checks the sources, updates the file, and advances `last_sync`). Use whatever recurring/scheduler mechanism the harness provides, running `tasks sync` every ~5 minutes. The concurrency rule above matters most here - every iteration re-reads the tasks file before writing, since other sessions may have edited it between runs. Confirm the loop is armed in one line; don't run a sync inline as part of starting it.

### freeform (anything else)

Interpret naturally: "close acme-orders", "ball with Bob now", "add a task: ...", "push acme-orders due to friday". Apply the edit (append log line with today's date), confirm in one line.

## Sources

Every source is matched to topics by the URLs in each topic's `links`, and by party/subject. Whatever a source turns up, only changes since `last_sync` matter. Use whichever MCP or CLI tool is available for it.

### kind: gmail

```yaml
- kind: gmail
```

Search threads covering the window (`newer_than:`/`after:`). Run inbox and sent as TWO SEPARATE searches - `in:inbox ...` and `in:sent ...` - never one combined query (a combined filter silently drops sent mail, and the user's own replies move the ball).

GOTCHA (this has caused misses): a thread search returns only a SUBSET of each thread's messages, so the newest message is often NOT in the search output - the snippet you see can be days stale. For every thread that a search surfaces as recent (or that maps to a topic), you MUST open the full thread and read the actual latest messages by date before concluding "no change". Do not report a thread's state from search output alone.

### kind: slack

```yaml
- kind: slack
  dms:                               # optional; always read these, they're not in any topic's links
    - name: <person>
      id: <slack user id>
  channels:                          # optional; always read these too
    - name: <channel>
      id: <slack channel id>
```

Read the channels/DMs whose URLs appear in `links` (channel ID is the last path segment), plus every DM in `dms` and channel in `channels` - people drop asks/updates there that never appear in a topic. Read the actual latest messages by timestamp, and check thread replies on any message that has them.

### kind: linear

```yaml
- kind: linear
  waiting_label: <label>             # optional; marks a ticket as blocked on a third party
```

For linear.app links, read the ticket plus its comments.

Also list issues assigned to the user (`me`) in the current cycle. Any such issue not already tracked in a topic (match by ticket URL in `links`) is a new task - propose a topic, create it if obvious, set `planned: true`, and record its ticket URL in `links`.

If `waiting_label` is set, it also acts as an inbox: list issues carrying that label, and any issue not already tracked in a topic (match by ticket URL in `links`) is a new task - propose a topic, create it if obvious, and record its ticket URL in `links`.

Post-sync step: mirror the label. For any topic with a Linear ticket in `links`, the label must match reality - present when the ball is with an external party, absent otherwise. Only touch tickets already in `links`; don't create tickets just to carry the label.

### kind: github

```yaml
- kind: github
```

For github.com links, use the `gh` CLI (`gh pr view`, `gh issue view`) including comments.
