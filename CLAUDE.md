# dotfiles

Symlink-based dotfiles, installed via `install.sh` (bash) — it `ln -is`'s files from this repo into `$HOME`.

## bin/

Personal scripts, on PATH via `.bash_profile` and `~/.zshrc` (`$HOME/dotfiles/bin`).

Shebang gotcha: `#!/usr/bin/env ruby` resolves to the asdf shim, which fails
outside a directory with a `.tool-versions` (there is no global one). Scripts
that should run from anywhere (e.g. launched by Tuna) must use a fixed
interpreter like `#!/usr/bin/ruby`.

## tmuxinator configs: one dir, two symlinks

All tmuxinator recipes live in `.tmuxinator/` in this repo. Both lookup paths
are symlinks to it: `~/.tmuxinator` AND `~/.config/tmuxinator` (XDG). The XDG
symlink matters: tmuxinator prefers `~/.config/tmuxinator` *if it exists*, and
`tmuxinator open/new` only looks in that top-priority dir (while `start`/`list`
search all dirs). Confirmed 2026-08-19: a stray `~/.config/tmuxinator/` real
dir made `mux open law` generate a fresh template there instead of opening the
existing recipe. The herdr scripts below read `~/.tmuxinator/` only. Side
effect of the double symlink: `tmuxinator list` shows every project twice —
cosmetic. If it recurs, don't hunt for "lost" files: check which dir won.

## herdr

`bin/herdr-mux <name-or-path>` boots a herdr workspace from a tmuxinator
recipe (`~/.tmuxinator/<name>.yml`): one tab per window, extra panes as
splits, `pre_window` first in every pane, and `claude`-launching windows
registered as agent panes via `herdr agent start` (with retry — the pane
shell may not be "available" right after creation). If the workspace
already exists it is focused instead — unless the recipe sets
`allow_multiple: true` (ignored by tmuxinator), which creates suffixed
copies (pa, pa-2, ...). Keep port-binding recipes (tables, servers)
singleton. Not ported: exact tmux layouts,
`on_project_*` hooks, `startup_window`/`attach`.

Herdr keybindings live in `herdr/config.toml` (symlinked to
`~/.config/herdr/config.toml`): ctrl+alt+hjkl = workspaces/tabs,
cmd+alt = agents, ctrl+alt+n = popup recipe picker
(`bin/herdr-mux-pick`, fzf), cmd+ctrl+1..9 = switch tab.
cmd+ctrl+hjkl is reserved for Rectangle (window halves) — Rectangle
registers global hotkeys, so any chord it owns never reaches
Ghostty/herdr. ctrl+alt+hjkl belongs to herdr: ALL of Rectangle's
plain ctrl+alt defaults (quarters, maximize, thirds, center, restore,
smaller/larger, …) are parked on explicit hyper chords
(cmd+ctrl+alt+shift + the action's original key). NB: writing an
empty dict for an action does NOT disable its default — Rectangle
falls back to the registered default; the only reliable override is
an explicit shortcut. Corner actions are keyed
topLeft/topRight/bottomLeft/bottomRight (NOT upperLeft/lowerLeft —
wrong keys are silently ignored). The ⌃⌥N/⌃⌥B todo-mode keys are also parked on hyper
(ctrl+alt+n is the herdr recipe picker); only the ⌃⌥⌘-arrow display
shortcuts remain on Rectangle's side. If a
Karabiner hyper key is ever set up, these parked chords will fire —
rebind them in Rectangle's prefs UI first. Rectangle shortcuts live in
`defaults com.knollsoft.Rectangle` (per-action dicts of keyCode +
NSEvent modifierFlags); Rectangle must be restarted after a
`defaults write`.
Reload with `herdr server reload-config`. Ghostty must pass the raw
chords through — see the disabled tmux-bridge keybinds in
`ghostty/config`.

The Oase-table-specific booter is `~/Projects/oasis/dotfiles/scripts/herdr-table`.

## Tuna script commands

Tuna (the launcher, tunaformac.com) auto-discovers scripts in
`~/Library/Scripts` — no Pro needed (additional directories via
Settings → Library → Scripts require Pro). Symlinks work. Docs:
https://tunaformac.com/docs/custom-scripts-and-script-directories

Metadata goes in leading comment lines:

```sh
#!/bin/sh
# @tuna.name My Command          # display name
# @tuna.subtitle What it does    # search-result subtitle
# @tuna.icon symbol:fish         # symbol:<SF Symbol> | bundle-id:<id> | app:<path> | file:<path>
# @tuna.mode inline              # inline (default) | background (Shelf task)
# @tuna.input arguments          # arguments (default) | stdin | none
# @tuna.output text              # none (default) | text (stages stdout for chaining)
```

Input arrives via "Run with Input…" in Tuna. With `@tuna.output text`, stdout
is staged in Tuna for chaining/copying — so scripts should print the result
plainly. `ulid2uuid` in `bin/` is the reference example (dual-use: terminal +
Tuna; it only touches the clipboard when stdout is a TTY).

The `raycast/` directory holds legacy Raycast script commands; Tuna versions
live in `bin/` with `@tuna.*` headers and get symlinked into
`~/Library/Scripts` by `install.sh`.
