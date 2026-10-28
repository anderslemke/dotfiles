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
ctrl+shift+j/k + ctrl+shift+1..9 = agents, ctrl+alt+n = popup recipe picker
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

Naming things in the agents grouped view: agent names default to
`claude-<workspace-label>-claude`; give an agent a custom display name with
`herdr agent rename <name-or-pane-id> "<new name>"` (revert with `--clear`),
or rename the workspace label itself with
`herdr workspace rename <workspace-id> <label>` (ids/names via
`herdr agent list` / `herdr workspace list`). The view also shows each
agent's live terminal title, which Claude Code sets to its current task —
that already answers "what is this session doing", while a rename gives a
stable label for what the table itself is for. The title row is enabled via
`[ui.sidebar.agents] rows` in `herdr/config.toml` (token
`terminal_title_stripped`; see `herdr --default-config` for all row tokens,
incl. per-agent overrides under `rows_by_agent`).

The Oase-table-specific booter is `~/Projects/oasis/dotfiles/scripts/herdr-table`.

## Ghostty over SSH: TERM=xterm-ghostty gotcha

Ghostty advertises `TERM=xterm-ghostty`; remote hosts without that terminfo
entry (e.g. gigalixir containers) degrade — confirmed 2026-08-18: multi-line
paste into a `gigalixir ps:remote_console` IEx breaks in Ghostty but works in
iTerm (which sends `xterm-256color`). Fix: `TERM=xterm-256color` before the
command — there's a `gigalixir` alias for this in `~/.zshrc`. Ghostty's
`shell-integration-features = ssh-env,ssh-terminfo` does NOT help for CLIs
that exec the ssh binary directly (gigalixir, fly, gcloud, …) since it's a
shell-function wrapper; and installing terminfo on ephemeral containers
doesn't stick. Same-shaped failures elsewhere (any REPL/TUI misbehaving on
paste only in Ghostty): try `TERM=xterm-256color` first.

## Ghostty clickable links: only http, https and file

> **Update 2026-10-28 (Ghostty 1.4.0, Claude Code 2.1.312, herdr 0.9.5):**
> the picture below is for 1.3.1 and Claude Code run *directly* in Ghostty.
> Three things changed; the subsection right after this one has the details
> and the fix. Short version: Ghostty is no longer the blocker for
> `obsidian://` — Claude Code's own renderer is — and inside herdr Claude
> Code emits **no** hyperlinks at all unless `FORCE_HYPERLINK=1` is set.
> **Working end state: Ctrl-click a `file://…​.md` link → note opens in
> Obsidian in one click**, via the herdr plugin in `herdr/plugins/obsidian-link`.

### 2026-10-28: where each link dies now (verified by click-test, see end)

Traced in the binaries/sources, not guessed:

- **Ghostty 1.4.0** rewrote OSC 8 opening on macOS for GHSA-cw69-wm67-5pv8
  (`macos/Sources/Helpers/UntrustedURL.swift`). Policy per scheme:
  `http`/`https`/`mailto` open directly; `file` opens directly via
  `NSWorkspace.open` if the target exists and is not executable (so a `.md`
  should land in the default `.md` app — Obsidian — *not* Finder);
  **any other scheme, `obsidian://` included, gets an "Open Link from
  Terminal Output?" Cancel/Open dialog**, Cancel is default, no
  "don't ask again". The `link` config option is still "can't currently be
  set" in 1.4.0's docs. New `link-osc8 = true|false` is only an on/off switch.
- **Claude Code 2.1.312 defangs every non-`https`/`http`/`file` markdown
  link** in assistant text: the renderer passes `linkSchemes = Set(["https",
  "http", "file"])`, and a link outside the set is rendered as plain text, no
  OSC 8. So `[x](obsidian://…)` is dead in the renderer before Ghostty ever
  sees it. Upstream issue closed as not planned (May 2026).
- **Claude Code decides OSC 8 support from `TERM_PROGRAM`** (list: ghostty,
  Hyper, kitty, alacritty, iTerm.app, iTerm2, WarpTerminal, plus the
  `supports-hyperlinks` heuristics). **herdr sets `TERM_PROGRAM=herdr` in
  every pane** (`src/pane.rs`), so under herdr Claude Code emits *no*
  hyperlinks — `file://` links stopped working too. This is why "links
  stopped working altogether" after moving the tables into herdr; Ghostty
  1.4.0 is innocent. Escape hatch in Claude Code's code: env
  `FORCE_HYPERLINK=1` (non-zero → hyperlinks on).
- **herdr captures the mouse by default** (`mouse_capture = true` in
  `herdr --default-config`: "Set false to let the terminal handle normal
  clicks, such as Cmd-clicking URLs"). herdr also has its own link hover /
  `pane.link.activate` path, so with hyperlinks restored a Cmd-click is
  handled by herdr first, not Ghostty. Which opener/scheme policy herdr
  applies on macOS is not yet verified.

**Fix, step 1 (shell):** in `~/.zshrc`

    if [[ -n "$HERDR_ENV" ]]; then
      export FORCE_HYPERLINK=1
    fi

then restart **the shell and** the Claude pane (env is read at launch; a
`claude --continue` under the old zsh still lacks the variable — `exit`,
`source ~/.zshrc`, relaunch). Done on Anders' machine 2026-10-28.

**Step 2, result (2026-10-28):** with `FORCE_HYPERLINK=1` the links are
clickable again, but **the gesture inside herdr is Option-click, not
Cmd-click** — Cmd-click does nothing because herdr owns the mouse. herdr
opens the link with its own opener, and for `file://…​.md` that **reveals the
note in Finder** (double-click there → Obsidian), i.e. the same two-click
path as under Ghostty 1.3.1. Ghostty 1.4.0's "open `file://` in the default
app" policy never runs, because the click never reaches Ghostty.

**Tried and reverted the same day: `ui.mouse_capture = false`.** herdr's
docs (quick-start, "Ctrl-click opens pane links") say that with capture off
"explicit hyperlinks are passed to the outer terminal", so Cmd-click should
have reached Ghostty 1.4.0 and opened the `.md` in Obsidian. Result after a
client restart: herdr's mouse UI was gone as documented, **Cmd-click still
did nothing, and Option-click still revealed the note in Finder**. So
something other than herdr is also in the way — most likely Claude Code's
own pressable-link handling (its text renderer registers `onClick` on links
and requests mouse reporting, so clicks go to Claude Code, not Ghostty).
Not investigated further; reverted to the default. Note herdr's gesture is
documented as **Ctrl-click**, with `http(s)` opened in the browser and
"other links need a matching plugin" — on Anders' Mac an Option-click
reveals `file://` notes in Finder, origin unconfirmed.

Reload gotcha: `herdr server reload-config` is server-side; the *client*
re-reads `mouse_capture` only on its own reload (`prefix+shift+r`, prefix =
`ctrl+b`) or a client restart (detach `ctrl+b q`, run `herdr` again).

**What actually opens Finder on Option-click: Claude Code.** Its text
renderer has `onClick` handlers on links and requests mouse reporting;
herdr forwards mouse to pane apps that ask for it, so the click lands in
Claude Code, whose file-link handler runs `open -R -- <path>` (reveal in
Finder) — confirmed in the 2.1.312 binary. Neither herdr nor Ghostty is
involved in that gesture.

### The fix that works (2026-10-28): a herdr link-handler plugin

herdr's own link handling fires on **Ctrl-click** (its docs: "the
modified-click modifier is Control on every platform, including macOS") and
checks `[[link_handlers]]` of enabled plugins first. So:
`herdr/plugins/obsidian-link/` is a local plugin whose handler matches
`^file://.*\.md$` and runs `open-in-obsidian.sh`, which percent-decodes the
path and runs `open "obsidian://open?path=<abs path>"`. Obsidian resolves an
absolute `path` to whichever vault contains it, so one plugin covers lemke,
Oase and FallEquinox. Verified: Ctrl-click on a ticket link → note open in
Obsidian, no Finder, no dialog; `herdr plugin log list --plugin
lemke.obsidian-link` shows the runs.

Setup on a machine: `herdr plugin link ~/dotfiles/herdr/plugins/obsidian-link`
(in `install.sh`; needs the herdr server running). Check with
`herdr plugin list`. The script also logs to `$HERDR_PLUGIN_STATE_DIR`.

Gesture summary inside herdr, for the global CLAUDE.md rule:
- **Ctrl-click** = herdr → plugin → Obsidian (one click). Use this.
- Option-click (or plain click) = Claude Code → reveal in Finder.
- Cmd-click = nothing; Ghostty never sees it.

`obsidian://` links stay dead (Claude Code defangs them before any of this),
so keep writing `file://` links. `ob <id>` remains the keyboard route.

### 2026-09-11 analysis (Ghostty 1.3.1, Claude Code directly in Ghostty)

Ghostty has **two** scheme filters, and the narrow one is what actually
governs. Both extracted from the 1.3.1 binary with `strings`, 2026-09-11:

1. A big **matching** regex that decides what text gets underlined:
   `https?://`, `mailto:`, `ftp://`, `file:`, `ssh:`, `git://`, `tel:`,
   `magnet:`, `ipfs://`, `ipns://`, `gemini://`, `gopher://`, `news:`
2. A much shorter **opening** allowlist — the only scheme strings in the
   binary are **`http`, `https`, `file`**. Anything else is matched but never
   opened. That is why `ipns://` does nothing even though it's in the regex.

The same filter applies to OSC 8 hyperlinks, so markdown links can't smuggle a
scheme past it either. And `file://` *is* opened — but Ghostty reveals it in
Finder rather than opening it, with no config option to change that.

**Consequences, all verified by testing rather than guessed:**

- `obsidian://` never works — raw or as a markdown link
- `ipns://` never works, so the scheme-hijack idea is dead (see below)
- `file://` works and lands in Finder. Obsidian is the default `.md` app
  (2026-09-11 — it was Windsurf, which Anders doesn't use), so a double-click
  there opens the note. Two clicks total
- Markdown links ARE clickable for allowed schemes, including long paths with
  emoji — Claude Code emits them as OSC 8. Raw URLs break on line wrap, so
  prefer `[Name](file:///…)` over a bare URL

**So: link notes as `[Name](file:///percent/encoded/path.md)`**, built with
`"file://" + urllib.parse.quote(abs_path, safe="/")`. To land in Obsidian
directly, use `ob` (this repo's `bin/ob`): `ob Pro-3ck2` opens a ticket note,
`ob "2 - 🌿 Areas/Drift/Kontekst"` a path, `-o`/`-f` for the Oase and
FallEquinox vaults.

Restore the `.md` association on a new machine:

    swift -e 'import AppKit; import UniformTypeIdentifiers
    NSWorkspace.shared.setDefaultApplication(
      at: URL(fileURLWithPath: "/Applications/Obsidian.app"),
      toOpen: UTType("net.daringfireball.markdown")!) { _ in }'

(`public.markdown` is not a registered UTI on macOS 26 — only the
daringfireball one takes.)

### When will Ghostty fix this? No date — checked 2026-09-11

Upstream status, so nobody has to research it again:

- [#4379](https://github.com/ghostty-org/ghostty/discussions/4379) proposed the
  `link` option on **2 Jan 2025**, with a working branch. mitchellh said he'd
  look "today sometime" on **15 May 2025**. On **10 Nov 2025** it was split
  into #9545/#9546/#9547 because the thread mixed conflicting requests.
- [#9547](https://github.com/ghostty-org/ghostty/discussions/9547) is now the
  canonical thread for user-configurable URL matchers. Labelled
  **feature-design** ("almost-accepted, pending design"). Last activity
  **17 Aug 2026**. No maintainer reply, no linked PR, no milestone. Obsidian
  is named explicitly in the thread as a scheme people want.
- [#9999](https://github.com/ghostty-org/ghostty/discussions/9999) asked for
  arbitrary schemes and was closed as a duplicate of #9547. A collaborator
  said there are no plans to widen the hardcoded regex, citing the narrow
  audience for niche schemes.
- Scope objection on record from a collaborator: "arbitrary string matching
  and script running are out-of-scope for a terminal emulator" — so the
  feature may land narrower than `link`, or not at all.

**Read:** 20 months from a proposal *with working code* to still-pending
design, and the implementation lives only on a fork. Don't plan around it.
`ob` is the answer for the foreseeable future. Several commenters note this is
what blocks their move off iTerm2 — which does support custom schemes via
Smart Selection, as do kitty (`url_prefixes`) and WezTerm (`hyperlink_rules`),
if it ever becomes worth switching for.

### The scheme-hijack: built, working, and still useless

`bin/build-obsidian-link-app` + `src/obsidian-link/main.swift` build a small
menu-bar app that registers as handler for `ipns://` and forwards to
`obsidian://`. It works: `open "ipns://open?vault=lemke&file=…"` from a shell
opens the note, confirmed in its log. It is useless anyway, because Ghostty
won't open `ipns://` links in the first place — filter 2 above. The app was
removed and the registration reset; the source is kept only in case Ghostty
ever implements its `link` option, at which point you'd point `link` straight
at `obsidian://` and not need the app at all.

Two traps worth remembering from that detour:

- `osacompile` ad-hoc-signs its applet. Patching Info.plist afterwards
  invalidates the signature and macOS then refuses to launch the app
  **silently**. Sign after the plist is final.
- A GURL Apple Event can arrive **before** `applicationDidFinishLaunching`, so
  anything the handler touches must tolerate a half-initialised app. A
  force-unwrapped `NSStatusItem!` crashed it, which looked like "the app won't
  stay resident".

## iTerm2: parity med Ghostty-opsætningen

Opsat 2026-09-11. Alt Ghostty-specifikt er porteret til **én dynamic profile**,
`iTerm2/DynamicProfiles/ghostty-parity.json`, symlinket til
`~/Library/Application Support/iTerm2/DynamicProfiles/`. iTerm læser den live —
ingen genstart, og den overlever ikke iTerms prefs-skrivning ved quit (dynamic
profiles ligger uden for `com.googlecode.iterm2.plist`). Det er hele grunden
til at bruge dem: iTerm holder prefs i hukommelsen og overskriver plist'en når
den lukkes, så `defaults write` mod en kørende iTerm går tabt.

Profilen genereres af `iTerm2/build-dynamic-profile.py`, som læser
`ghostty/config` + Ghosttys eget temafil
(`/Applications/Ghostty.app/Contents/Resources/ghostty/themes/<theme>`). Skifter
du tema, font eller størrelse i Ghostty: kør scriptet igen, så følger iTerm med.

Profilen hedder "Ghostty" og arver resten fra Default (`Dynamic Profile Parent
Name`). En dynamic profile kan ikke gøre sig selv til default — det gøres én
gang i Settings → Profiles → Other Actions → Set as Default.

### Tastaturet — hvad iTerm kan selv, og hvad der skulle hjælpes

Målt med `bin/keycapture -k` (viser de rå bytes for et chord, kitty-dekodet):

- **iTerm 3.6 implementerer kitty keyboard-protokollen** (`pushKeyReportingFlags`
  / `csiU` i binæren; svarer på `CSI ?u` og honorerer `CSI >15u`). Derfor
  virker herdrs `ctrl+alt+hjkl`, `ctrl+alt+n`, `ctrl+shift+j/k` og
  `ctrl+shift+1..9` uden videre — samme sekvenser som Ghostty sender
  (`ESC [104;7u`, `ESC [106:74;6u`, …).
- **cmd-chords når aldrig tty'en i iTerm.** `cmd+ctrl+1..9` (herdrs
  `switch_tab`) gav intet output overhovedet, kun modifier-events. Derfor er de
  ni chords mappet eksplicit i profilens `Keyboard Map` til
  `ESC [<codepoint>;13u` (13 = 1 + ctrl 4 + super 8 i kitty-modifierkodningen).
  Bivirkning: trykker du `⌘⌃1` uden for herdr, står der `^[[49;13u` i shellen.
- Ghostty har kun **fem** tastebindinger der sender tegn til terminalen
  (`ghostty +list-keybinds --default | grep -E 'esc:|text:'`): `⌘←/⌘→` = `^A`/`^E`,
  `⌘⌫` = `^U`, `⌥←/⌥→` = `ESC b`/`ESC f`. De er identiske med iTerms preset
  "Natural Text Editing", som profilen indeholder. Bemærk: profil-mappings
  vinder over iTerms globale, så `⌘←/⌘→` skifter **ikke** længere faneblad.
- Resten af Ghosttys `super+…`-genveje (tabs, splits, søgning, font-størrelse,
  `⌘K`, `⌘⏎`) matcher iTerms defaults 1:1 — intet at gøre.
- Option er `Normal` i begge (Danish layout skal bruge ⌥ til `[ ] { }`), hvilket
  også er grunden til at `alt+shift+j/k` aldrig kunne bruges til herdr.

Keymap-formatet i profilen er iTerms eget legacy-format `"0x<tegn>-0x<modifiers>"`
(NSEvent-flag: shift 0x20000, ctrl 0x40000, option 0x80000, cmd 0x100000,
numpad 0x200000 — piletaster har numpad-flaget med). Værdien er
`{Action: 10, Text: "…"}` for ESC + tekst og `{Action: 11, Text: "0x1"}` for rå
hex. Se `/Applications/iTerm.app/Contents/Resources/PresetKeyMappings.plist`
for facit.

### Fælder

- **Fontnavnet skal være PostScript-navnet**, ikke familienavnet:
  `JetBrainsMonoNFM-Regular 15`, ikke `JetBrainsMono Nerd Font Mono 15`.
- Profilen sætter `Use Separate Colors for Light and Dark Mode = false`; ellers
  slår kun halvdelen af farverne igennem (Default-profilen har den slået til).
- `osascript` + System Events til at *sende* testtastetryk er upålideligt:
  chordet lander i den app der tilfældigvis er forrest (ramte både Claudes
  prompt og Zen under opsætningen). Kør `keycapture -k` og tryk selv.

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

## gh: `gh pr edit` fails on oase-app repos

`gh pr edit <n> --body ...` dies with `GraphQL: Projects (classic) is being deprecated ... (repository.pullRequest.projectCards)` (seen 2026-09-25). Nothing is changed. Edit through the REST API instead, which does not touch project cards:

```
gh api repos/oase-app/<repo>/pulls/<n> -q .body > /tmp/b.md   # edit the file
gh api -X PATCH repos/oase-app/<repo>/pulls/<n> -F body=@/tmp/b.md
```
