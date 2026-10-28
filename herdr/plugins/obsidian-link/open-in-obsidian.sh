#!/bin/bash
# herdr link handler: file:///abs/path/note.md -> obsidian://open?path=/abs/path/note.md
#
# Invoked by herdr with HERDR_PLUGIN_CLICKED_URL set (see herdr-plugin.toml).
# Obsidian resolves an absolute `path` to the vault that contains it, so this
# works for every vault (lemke, Oase, FallEquinox) without naming it.
set -euo pipefail

url="${HERDR_PLUGIN_CLICKED_URL:-${1:-}}"
log="${HERDR_PLUGIN_STATE_DIR:-/tmp}/open-in-obsidian.log"

if [ -z "$url" ]; then
  echo "$(date +%FT%T) no clicked url" >> "$log"
  exit 1
fi

# Strip scheme and optional "localhost" host, then percent-decode.
path="${url#file://}"
path="${path#localhost}"
path=$(python3 -c 'import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))' "$path")

if [ ! -f "$path" ]; then
  echo "$(date +%FT%T) not a file: $path (from $url)" >> "$log"
  /usr/bin/open -R "$path" 2>/dev/null || true
  exit 1
fi

encoded=$(python3 -c 'import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1], safe=""))' "$path")
echo "$(date +%FT%T) open $path" >> "$log"
exec /usr/bin/open "obsidian://open?path=$encoded"
