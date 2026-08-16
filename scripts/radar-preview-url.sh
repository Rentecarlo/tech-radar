#!/usr/bin/env bash
# Print a Build Your Own Radar link that renders radar.json from a given git
# ref, so a change can be seen on the radar before it is merged.
#
#   ./scripts/radar-preview-url.sh              # current branch
#   ./scripts/radar-preview-url.sh main         # any branch, tag or commit SHA
set -euo pipefail

ref="${1:-$(git rev-parse --abbrev-ref HEAD)}"

# Works with both SSH and HTTPS remotes.
slug=$(git remote get-url origin \
  | sed -e 's|^git@github.com:||' -e 's|^https://github.com/||' -e 's|\.git$||')

raw="https://raw.githubusercontent.com/${slug}/${ref}/radar.json"
encoded=$(printf '%s' "$raw" | sed -e 's|:|%3A|g' -e 's|/|%2F|g')

echo "https://radar.thoughtworks.com/?sheetId=${encoded}"
