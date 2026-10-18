#!/usr/bin/env bash
# Usage: ./create_labels.sh OWNER/REPO   (needs the GitHub CLI, logged in with: gh auth login)
set -euo pipefail
REPO="${1:?Usage: ./create_labels.sh OWNER/REPO}"
DIR="$(cd "$(dirname "$0")" && pwd)"
python3 - "$DIR/labels.json" <<'PY' | while IFS=$'\t' read -r name color desc; do
import json, sys
for l in json.load(open(sys.argv[1])):
    print(f"{l['name']}\t{l['color']}\t{l['description']}")
PY
  gh label create "$name" --color "$color" --description "$desc" --repo "$REPO" --force
done
