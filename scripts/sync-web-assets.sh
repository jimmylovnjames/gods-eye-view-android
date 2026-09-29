#!/usr/bin/env bash
set -euo pipefail

SRC="${1:-}"
DEST="$(cd "$(dirname "$0")/.." && pwd)/app/src/main/assets/www"

if [[ -z "$SRC" || ! -d "$SRC" ]]; then
  echo "usage: $0 /path/to/gods-eye-view/dist" >&2
  exit 1
fi

if [[ ! -f "$SRC/index.html" ]]; then
  echo "no index.html in $SRC — run npm run build in gods-eye-view first" >&2
  exit 1
fi

rm -rf "$DEST"
mkdir -p "$DEST"
cp -R "$SRC"/. "$DEST"/
echo "synced $SRC -> $DEST"
