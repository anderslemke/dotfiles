# dotfiles

Symlink-based dotfiles, installed via `install.sh` (bash) — it `ln -is`'s files from this repo into `$HOME`.

## bin/

Personal scripts, on PATH via `.bash_profile` and `~/.zshrc` (`$HOME/dotfiles/bin`).

Shebang gotcha: `#!/usr/bin/env ruby` resolves to the asdf shim, which fails
outside a directory with a `.tool-versions` (there is no global one). Scripts
that should run from anywhere (e.g. launched by Tuna) must use a fixed
interpreter like `#!/usr/bin/ruby`.

## herdr

`bin/herdr-mux <name-or-path>` boots a herdr workspace from a tmuxinator
recipe (`~/.tmuxinator/<name>.yml`): one tab per window, extra panes as
splits, `pre_window` first in every pane, and `claude`-launching windows
registered as agent panes via `herdr agent start` (with retry — the pane
shell may not be "available" right after creation). If the workspace
already exists it is focused instead. Not ported: exact tmux layouts,
`on_project_*` hooks, `startup_window`/`attach`.

Herdr keybindings live in `~/.config/herdr/config.toml` (cmd+ctrl =
workspaces/tabs, cmd+alt = agents); reload with `herdr server
reload-config`. Ghostty must pass the raw chords through — see the
disabled tmux-bridge keybinds in `ghostty/config`.

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
