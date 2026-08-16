# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Read [README.md](README.md) first.** It is the source of truth for the blip schema, the valid ring and quadrant values, the radar URL, and the branch/commit conventions. Don't restate any of that here — keep this file to what the README doesn't cover, and update the README when the data format changes.

## Shape of the work

There is no application code, build, lint, or test setup — the repository is one data file, `radar.json`, rendered by Thoughtworks' hosted Build Your Own Radar (BYOR). Don't go looking for a test command or a dev server; there isn't one. Every change is a data change: adding, moving, or retiring a blip, plus the prose justifying it.

The interesting work is usually the `description`, not the JSON. A blip is an argument about how we build things, so a change should say why the technology sits at that ring, in our context.

## Verifying a change

`radar.json` being valid JSON is necessary but not sufficient. BYOR silently drops any blip whose `ring` or `quadrant` it doesn't recognise (see the README), so a "successful" change can still leave the blip invisible with no error anywhere.

You cannot confirm the render from the terminal — BYOR is a client-side app, so fetching the radar URL returns an empty shell. What you *can* check without a browser:

- `radar.json` parses, and every `ring`/`quadrant` value is in the permitted set.
- The raw URL still returns `200` with `Access-Control-Allow-Origin: *` — BYOR fetches it cross-origin from the browser, so it breaks if the repository ever goes private.

Say plainly that the render itself is unverified, and ask the user to open the radar link, rather than implying a change is confirmed working.

Every pull request must carry a preview link rendering that branch's `radar.json`. Generate it with `./scripts/radar-preview-url.sh` after pushing — the branch has to be on the remote for BYOR to fetch it — and put it at the top of the PR body, as `.github/pull_request_template.md` asks.

## This repository is public

`tech-radar` is one of only two public repositories in the org; everything else is private. Blip descriptions are therefore world-readable, so keep internal repository names, service names, and architecture detail out of them. Cite that evidence in the PR or in chat instead, where it stays behind org access.

## Upstream constraints

The ring and quadrant names, the `isNew`-must-be-a-string quirk, and the silent-drop behaviour are all imposed by `thoughtworks/build-your-own-radar` — respectively `src/graphing/config.js` (`getRings`/`getQuadrants`) and `src/util/factory.js` (`plotRadarGraph`). Check that repository's `master` before asserting anything about the format; it changes without notice, and the Hold→Caution rename already caught this repository out once.
