#!/usr/bin/env bash
# Renames the tmux window to reflect Claude state, branch(es), and a
# one-word topic for the current session.
#
# Title format:
#   idle/working:  [<base> ](<branches>)[ <topic>]
#   waiting:       👋 [<base> ](<branches>)[ <topic>]
#
# Branches: if cwd has sibling oase-app/ + mainframe/, both branches are
# shown slash-joined (or collapsed to one if they match). Otherwise the
# branch at cwd. The "tableN" base is dropped — tmux's window index
# already shows N.
#
# Topic: stored per tmux pane under ~/.claude/topics/. Generated once
# from the first user prompt after a fresh start / /clear via a headless
# `claude -p` call. Cleared by SessionStart hook on source=clear.
#
# Usage: tmux-window-title.sh waiting | working | session_start

# Guard against recursion: the background `claude -p` below inherits
# TMUX_PANE and would otherwise re-fire these hooks against the parent's
# pane, cascading the title.
[ -n "$CLAUDE_TOPIC_HEADLESS" ] && exit 0

state="$1"
[ -n "$TMUX_PANE" ] || exit 0

input=$(cat 2>/dev/null)
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
prompt=$(printf '%s' "$input" | jq -r '.prompt // empty' 2>/dev/null)
src=$(printf '%s' "$input" | jq -r '.source // empty' 2>/dev/null)
cwd="${cwd:-$PWD}"

topic_dir="$HOME/.claude/topics"
mkdir -p "$topic_dir" 2>/dev/null
pane_key=$(printf '%s' "$TMUX_PANE" | tr -d '%')
topic_file="$topic_dir/$pane_key.txt"

# /clear (SessionStart source=clear): drop the cached topic.
# SessionStart in general: render without the 👋 (state="idle").
if [ "$state" = "session_start" ]; then
  [ "$src" = "clear" ] && rm -f "$topic_file"
  state="idle"
fi

git_branch() { git -C "$1" rev-parse --abbrev-ref HEAD 2>/dev/null; }

compute_branch() {
  local b=""
  if [ -d "$cwd/oase-app" ] && [ -d "$cwd/mainframe" ]; then
    local app mf
    app=$(git_branch "$cwd/oase-app")
    mf=$(git_branch "$cwd/mainframe")
    if [ -n "$app" ] && [ -n "$mf" ]; then
      if [ "$app" = "$mf" ]; then b="$app"; else b="$app/$mf"; fi
    fi
  fi
  [ -z "$b" ] && b=$(git_branch "$cwd")
  printf '%s' "$b"
}

apply_title() {
  local branch="$1" topic="$2" st="$3"
  local current base tmp new
  current=$(tmux display-message -p -t "$TMUX_PANE" '#W' 2>/dev/null) || return 0
  base="${current#👋 }"
  # Iteratively strip trailing " (...) word?" blocks (handles past pollution).
  while :; do
    tmp=$(printf '%s' "$base" | sed -E 's/ ?\([^)]+\)( [^ ]+)?$//')
    [ "$tmp" = "$base" ] && break
    base="$tmp"
  done
  # Renders from a non-git cwd have no "(branch)" anchor, so the topic lands as
  # a bare trailing word the loop above can't see — strip repeats of the
  # current topic too, or every branchless render appends another copy.
  if [ -n "$topic" ]; then
    while [ "${base% $topic}" != "$base" ]; do base="${base% $topic}"; done
    [ "$base" = "$topic" ] && base=""
  fi
  [[ "$base" =~ ^table[0-9]+$ ]] && base=""
  new="$base"
  [ -n "$branch" ] && new="${new:+$new }($branch)"
  [ -n "$topic" ] && new="${new:+$new }$topic"
  if [ "$st" = "waiting" ]; then
    if [ -z "$new" ]; then new="👋"; else new="👋 $new"; fi
  fi
  tmux rename-window -t "$TMUX_PANE" "$new"
}

topic=""
[ -f "$topic_file" ] && topic=$(cat "$topic_file" 2>/dev/null)
branch=$(compute_branch)
apply_title "$branch" "$topic" "$state"

# Generate a one-word topic in the background on the first prompt after
# a fresh start / /clear. Once written, re-render so the title picks it up.
if [ "$state" = "working" ] && [ -z "$topic" ] && [ -n "$prompt" ]; then
  (
    summary_prompt="Reply with exactly ONE lowercase word (letters, digits, or hyphens only) naming the topic of this user request. No punctuation, no quotes, no explanation. Request:

$prompt"
    new_topic=$(CLAUDE_TOPIC_HEADLESS=1 claude -p "$summary_prompt" 2>/dev/null \
      | tr -d '[:space:]' \
      | tr '[:upper:]' '[:lower:]' \
      | sed 's/[^a-z0-9-]//g' \
      | cut -c1-24)
    if [ -n "$new_topic" ]; then
      printf '%s' "$new_topic" > "$topic_file"
      apply_title "$(compute_branch)" "$new_topic" "$state"
    fi
  ) >/dev/null 2>&1 </dev/null &
fi
