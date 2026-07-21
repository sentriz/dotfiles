---
name: rec
description: Recommend 5 music releases to check out today based on ListenBrainz listening history and gonic library
---

# Music Recommendations

Generate 5 release recommendations based on listening patterns and existing library.

## Data sources

- **ListenBrainz user**: `sentriz`
- **ListenBrainz API base**: `https://api.listenbrainz.org/1`
- **Gonic DB**: `ssh sam "sqlite3 /mnt/containers/gonic/gonic.db \"<query>\""` (on server "sam")

The gonic `plays` table is NOT accurate for play counts. ListenBrainz is the source of truth for what the user actually listens to. The gonic DB is only used to check what releases are in the library.

## Procedure

### Step 1: Gather listening context

ListenBrainz stats endpoints only support predefined calendar-based ranges (no custom date windows):
`all_time`, `year`, `month`, `week`, `this_year`, `this_month`, `this_week`, `quarter`, `half_yearly`

Fetch these in parallel:

1. **Top 150 artists (long-term)** - overall taste profile:
   `https://api.listenbrainz.org/1/stats/user/sentriz/artists?count=150&range=half_yearly`

2. **Recent listens** - what's playing right now, always reliable regardless of calendar boundaries:
   `https://api.listenbrainz.org/1/user/sentriz/listens?count=100`

3. **Top releases (this month)** - what's in heavy rotation:
   `https://api.listenbrainz.org/1/stats/user/sentriz/releases?count=30&range=this_month`

### Step 2: Generate candidate recommendations

Based on the listening data, brainstorm ~15 candidate album recommendations. Think about:

- Artists/scenes adjacent to the top artists
- Deeper cuts from artists already in rotation
- Records that sit at the intersection of multiple taste threads
- Classic or overlooked releases from genres that appear heavily
- Don't just recommend the most famous record by a well-known artist - lean toward interesting, less obvious picks

### Step 3: Check candidates against gonic library

For each candidate, check if it exists in the gonic DB:

```sql
SELECT a.name, al.tag_title, al.tag_year
FROM artists a
JOIN album_artists aa ON a.id = aa.artist_id
JOIN albums al ON aa.album_id = al.id
WHERE al.tag_title IS NOT NULL
AND a.name LIKE '%<artist>%'
```

Batch multiple artist checks into a single SSH/sqlite3 call where possible.

### Step 4: Decide on each candidate

For each candidate:

- **Not in library**: good recommendation, include it
- **In library**: check if the user has been listening to it on ListenBrainz recently. If they have, skip it (they already know it). If they haven't listened to it much/at all, it's a great "you own this but haven't explored it" recommendation - include it with a note

### Step 5: Repeat until 5

If fewer than 5 candidates survive, go back to step 2 and generate more. Aim for a good mix:

- At least 1-2 releases the user does NOT own (new discoveries)
- At least 1-2 releases the user DOES own but hasn't explored (dig into your own crate)
- Variety across genres/eras - don't recommend 5 post-punk records unless that's clearly the current mood

## Output format

Present the 5 recommendations as a concise list. For each:

- **Artist - Album** (year)
- One sentence on why this fits right now
- Note if it's already in the library ("you have this" / "new to you")

Keep it short. No preamble, no lengthy analysis of listening habits - just the recs.
