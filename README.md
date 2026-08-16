# Veygo Technology Radar

Veygo's technology radar, as inspired by [Thoughtworks' Technology Radar](https://www.thoughtworks.com/radar).

It records the technologies we're using, trialling, or deliberately avoiding, and why. Anything discussed in our engineering community, CoPs, and so on that warrants further investigation belongs on here.

## View the radar

**[👉 Open the Veygo Technology Radar](https://radar.thoughtworks.com/?sheetId=https%3A%2F%2Fraw.githubusercontent.com%2FRentecarlo%2Ftech-radar%2Fmain%2Fradar.json)**

There is no site to deploy and nothing to run. The radar is rendered by Thoughtworks' hosted [Build Your Own Radar](https://radar.thoughtworks.com/) (BYOR) app, which reads [`radar.json`](radar.json) straight from this repository. The link above is simply BYOR's URL with our raw `radar.json` URL passed as the `sheetId` query parameter:

```
https://radar.thoughtworks.com/?sheetId=<URL-encoded link to radar.json>
```

Notes:

- Merged changes can take up to five minutes to show up, as raw GitHub caches the file for 300 seconds. Force-refresh your browser if you're impatient.
- The link tracks `main`. Swap `main` for a commit SHA in the encoded URL if you need a permanent link to a fixed snapshot of the radar.
- BYOR fetches the file from your browser, so this repository has to stay public. If it's ever made private, the hosted app won't be able to read it and we'd need to self-host BYOR instead.

## Add or move a blip

Each entry ("blip") is an object in the `radar.json` array:

```json
{
  "name": "Temporal",
  "ring": "adopt",
  "quadrant": "platforms",
  "isNew": "TRUE",
  "description": "We've identified durable execution and asynchronous workflow orchestration as a solution for some of our scalability & reliability issues, and <a href='https://temporal.io/'>Temporal</a> is a platform that provides these capabilities"
}
```

| Field | What it's for |
| --- | --- |
| `name` | The label shown on the radar. |
| `ring` | How far we've committed to it. One of `adopt`, `trial`, `assess`, `caution`. |
| `quadrant` | Which slice it sits in. One of `techniques`, `platforms`, `tools`, `languages & frameworks`. |
| `isNew` | `"TRUE"` if this is a new blip, `"FALSE"` if it was on a previous radar. Note it's the string, not a boolean. |
| `description` | Why it's on the radar, and why at that ring. Inline HTML is allowed — use single quotes for attributes so you don't have to escape them, e.g. `<a href='https://example.com'>link</a>`. |
| `status` | Optional. Shows movement since the last radar: `New`, `Moved In`, `Moved Out`, or `No Change`. |

The ring and quadrant names above are the only ones the hosted BYOR app accepts. Matching is case-insensitive, so `Adopt` and `adopt` both work — we use lowercase for consistency. **A blip whose `ring` or `quadrant` isn't one of those values is silently dropped from the radar.** There's no error and no warning; it simply won't be drawn, so check your blip actually appears after a change.

The outermost ring was renamed from **Hold** to **Caution** in a recent BYOR release. `hold` is still accepted and rendered as Caution, but write `caution` in new entries.

To move a technology between rings, edit its existing entry — don't add a second one — and set `status` to `Moved In` or `Moved Out` so the change is visible on the radar itself. Beyond that, git history is the record of what changed and when.

## Preview a change before it's merged

BYOR will render any publicly reachable `radar.json`, including the one on your branch — so a change can be seen on the radar before anyone merges it. Generate the link with:

```sh
./scripts/radar-preview-url.sh          # current branch
./scripts/radar-preview-url.sh main     # or any branch, tag, or commit SHA
```

**Every pull request should include this link**, and the PR template asks for it. Reviewing a radar change by reading a JSON diff tells you the file parsed; it doesn't tell you the blip landed in the right place, or landed at all. Open your own link before requesting a review — a blip with an unrecognised `ring` or `quadrant` is dropped silently, and the preview is the only place that shows up.

## Contributing

1. Branch off `main` as `feat/NNNN-short-description`, where `NNNN` is the next zero-padded number in sequence.
2. Commit with a matching subject: `NNNN: short description`.
3. Raise a pull request, including the preview link above, so the change gets a second pair of eyes — the radar is a statement about how we build things, so the discussion on the PR matters as much as the entry itself.
