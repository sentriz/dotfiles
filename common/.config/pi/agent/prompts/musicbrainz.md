---
description: Add or edit MusicBrainz entities (artists, labels, releases) through the browser
argument-hint: "[add <url> | instructions]"
---
# MusicBrainz editing

**Task:** ${@:-none given - ask what to do}

Edits go into a public database under the user's account (`sentriz`). Be conservative: research
first, only enter what a source supports, and never submit a release without the user reviewing it
unless they say otherwise.

Keep this file current: when you learn something that would have saved you time (a style rule, a
form quirk, a lookup that works), add it in the relevant section as you go.

## Invocation

The task above is the whole instruction. `add <url>` (a Bandcamp/store album link) means: import
that release via Harmony, following the **Releases** section below. Before opening Harmony, do the
prep work:

1. Identify the artist(s) and label from the source page, and make sure each one exists in MB.
   Create anything missing first (see Artists / Labels) - the release editor can't create artists.
2. Find the same release on other providers and collect their ids, plus a UPC/GTIN if there is one.
   The user's usual route is to find the album on Spotify and put its link through
   <https://www.isrcfinder.com/upc-finder/>. Without a browser, Deezer's public API gives the same
   thing unauthenticated: `https://api.deezer.com/search/album?q=...` then
   `https://api.deezer.com/album/<id>`, which includes `upc`. iTunes has
   `https://itunes.apple.com/search?term=...&entity=album`. Search by album title *and* by track
   title, since small labels title albums as catalogue numbers. If nothing turns up, the release is
   store-exclusive and has no barcode - leave it blank rather than inventing one.
3. Hand Harmony *everything* at once - its lookup takes a URL, a GTIN and per-provider ids together,
   and merges them into one release with all the external links and the barcode filled in. The
   permalink query string is the whole form, so open a new tab straight at it instead of typing into
   the fields:
   `https://harmony.pulsewidth.org.uk/release?url=<urlencoded>&gtin=<upc>&spotify=<id>&deezer=<id>&itunes=<id>&tidal=<id>&qobuz=<id>&musicbrainz=&discogs=&region=GB,US,DE,JP`
   Empty params are fine. Screenshot the result: Harmony reports which providers it skipped and why
   ("GTIN is unknown, lookups for the following providers were skipped") - that tells you whether
   your ids were used.

## Ground rules

- Verify facts before typing them. Legal names, founding years, aliases: find a source (label/artist
  Bandcamp "about", SoundCloud bio, label copy, press). If a source contradicts what the user said,
  say so and confirm before entering it.
- Check the entity doesn't already exist before creating it. Search is unreliable for new/odd names
  (underscores, digits), so check more than one way:
  `curl -s "https://musicbrainz.org/ws/2/artist?query=NAME&fmt=json" -H 'User-Agent: cli/1.0' | jq -r '.artists[]?|"\(.id) \(.name) (\(.disambiguation))"'`
  The create form's own "Possible duplicates" warning is the strongest signal - if it fires, abandon
  the form and reuse the existing MBID.
- Edit notes: one or two lines, plain, with the source URLs. No emdashes, no restating the form.
- Leave fields blank rather than guessing. An empty begin date is better than a wrong one.
- MB does *not* search for existing recordings when adding a release - every track defaults to
  "(add a new recording)". That default is only correct if you checked:
  `curl -s "https://musicbrainz.org/ws/2/recording?artist=MBID&limit=100&fmt=json" -H 'User-Agent: cli/1.0' | jq -r '.recordings[]?|.title'`
- Verify after submitting with the API rather than reading the page:
  `curl -s "https://musicbrainz.org/ws/2/label/MBID?inc=artist-rels+url-rels&fmt=json" -H 'User-Agent: cli/1.0' | jq`

## Chrome MCP × MusicBrainz mechanics

- Forms are React. `fill` **appends** to a field that already has a value (Harmony imports, prefilled
  sort names). To replace: `click` the field, `press_key key="Control+a"`, then `type_text`.
- `fill` on a MB `<select>` sometimes never becomes interactive (tooltips overlap it) and options can
  have leading whitespace (`"   Original Production"`). Set it with a script instead:
  `evaluate_script pageId=N function='() => { const s=document.getElementById("id-edit-label.type_id"); const o=[...s.options].find(o=>o.text.trim()==="Original Production"); s.value=o.value; s.dispatchEvent(new Event("change",{bubbles:true})); }'`
  Date-part inputs (`id-edit-label.period.begin_date.year`) often need the same treatment, via the
  native value setter plus `input` + `change` events.
- Every autocomplete (artist, label, area, relationship target) works the same way: type the name,
  wait ~2s, screenshot to confirm the dropdown, then `press_key key=Enter` to take the highlighted
  row. Confirm afterwards - the field turns green and a "You selected X" tooltip appears.
- If an autocomplete can't find an entity (indexed search lag on brand-new or underscore names),
  **paste the MBID** into the field instead of the name. That always resolves.
- uids change on every re-render (each dialog/row edit). Re-snapshot immediately before each click,
  and don't reuse uids across steps.
- Relationship dialogs: `Add relationship` → set *Related type* → relationship type autocomplete →
  target autocomplete → read the **Preview** line to check the direction ("Luke Reddy performs as
  Lucas Ogma") → `Change direction` if wrong → `Done`. `Done` stays disabled until required fields
  resolve.
- External links: fill the "Add link" box, wait, and MB detects the type and appends a fresh
  "Add another link" box with a new uid. Add links one at a time, re-snapshotting between.
- Screenshots beat snapshots for verifying MB forms - tooltips, yellow style warnings and
  green/red field validation only show up visually.
- The submit button is `Enter edit` (artist/label) or `Finish` (release editor). Clicking it applies
  the edit immediately - don't click it if the user wants to review.

## Artists

- Type Person for solo acts; Group for bands/duos. Set gender only for Person.
- Sort name: invert firstname-surname shaped names ("Ogma, Lucas"), leave mononyms/wordmarks as-is.
- Area = country the artist is identified with; smaller area only if strongly associated.
- **Begin date on a Person is date of birth**, not "started producing". Leave it blank unless a
  birth date is sourced.
- Disambiguation: short and factual, e.g. "Irish techno producer".
- Stage name vs legal name: two Person entities linked by the `performs as / performance name of`
  relationship, added from the legal-name side. Put the social/streaming links on the stage-name
  entity (they're named after it) and business relationships (label founder) on the legal-name
  entity. If only one is ever credited, prefer a single entity plus an alias.

## Labels

- Type: `Original Production` for a label that produces its own catalogue; `Imprint` for a
  brand-only label; `Distributor`/`Publisher` etc. for those roles.
- Area can be a city if sourced (Bandcamp footer gives "Dublin, Ireland").
- Begin date = founding year, usually inferable from the first release; say so in the edit note.
- Founder: relationship to Artist, type `founded / founders`, target the person entity.
- Bandcamp is the trap: `<name>.bandcamp.com` may be a **label** page or an **artist** page. Read
  the page copy, and check whether a separate artist subdomain exists at all - an unregistered
  subdomain returns Bandcamp's signup page with HTTP 200, so compare `<title>`:
  `curl -sL URL | grep -oiE '<title>[^<]*'` (`Signup | Bandcamp` means it doesn't exist).

## Releases (via Harmony)

Harmony (`https://harmony.pulsewidth.org.uk`) does the scraping; assume its output needs correcting.
Open the prefilled lookup URL (see **Invocation**), click `Import into MusicBrainz` - it opens the MB
release editor in a new tab - then fix, tab by tab:

**Release information**
- Artist credit: click `Edit` next to Artist. Harmony dumps the whole raw string into one row.
  Rebuild it: one row per artist, `Artist in MusicBrainz` = the MB entity, `Artist as credited` = the
  name printed on the release (e.g. entity "Lucas Ogma" credited as "Lucas"), join phrase with
  surrounding spaces (`" and "`, `" & "`, `" feat. "`). The Preview line shows the final credit.
- Primary type (EP/Album/Single), Status, Language (Harmony's language guess is often wrong), Script.
- Label: replace Harmony's plain text with the real MB label (paste its MBID) and set Cat. No.
- Barcode: whatever GTIN you fed Harmony. Bandcamp-only releases have none - confirm the release
  isn't on streaming (`https://api.deezer.com/artist/<id>/albums` for artists that already have store
  links, plus a track-title search) before leaving it blank.
- Keep Harmony's annotation (release credits) and all the external links it collected.

**Tracklist**
- Move artist names out of titles into the Artist column - Harmony leaves "Artist - Title" prefixes.
  Same for `feat.` credits: they belong in the track artist credit, never the title.
- Set per-track credits by clicking each row's `Edit`: remove the credit rows that don't apply and
  clear the leftover join phrase. Don't tick "change all artists on this release that match ...".
- Titles: MB title style. Extra title info goes in parentheses, lowercase for descriptive words, so
  `(Original Mix)` → `(original mix)` (valid ETI - it is not removed), `Rite Of Passage` →
  `Rite of Passage`. The editor's own yellow warnings flag most of this.

**Recordings** - all rows say "(add a new recording)" by default; confirm against the API (above)
before accepting it, especially for artists that already exist in MB.

**Edit note** - Harmony writes a good one; append a short line describing the manual corrections.

Cover art: Harmony can submit it after the release exists - don't upload it by hand.
