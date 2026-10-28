#!/usr/bin/env python3
"""Generate the iTerm2 "Ghostty" dynamic profile from the Ghostty config.

Source of truth is ~/dotfiles/ghostty/config (theme name, font, font size) plus
the theme file shipped with Ghostty.app, so the two terminals cannot drift.

    python3 ~/dotfiles/iTerm2/build-dynamic-profile.py

Writes DynamicProfiles/ghostty-parity.json next to this script. iTerm2 picks up
changes to that file live (it is symlinked into
~/Library/Application Support/iTerm2/DynamicProfiles/) — no restart needed.
"""
import json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
GHOSTTY_CONFIG = os.path.expanduser("~/dotfiles/ghostty/config")
THEME_DIR = "/Applications/Ghostty.app/Contents/Resources/ghostty/themes"
OUT = os.path.join(HERE, "DynamicProfiles", "ghostty-parity.json")

# Stable — changing it makes iTerm treat this as a brand new profile.
GUID = "6B0C9C1E-4A31-4F8F-9B77-0C2A7F1E8D34"

# PostScript names for the Nerd Font families we might meet in ghostty/config.
PS_NAMES = {
    "JetBrainsMono Nerd Font Mono": "JetBrainsMonoNFM-Regular",
    "JetBrainsMono Nerd Font": "JetBrainsMonoNF-Regular",
    "JetBrainsMono Nerd Font Propo": "JetBrainsMonoNFP-Regular",
}


def parse_kv(path):
    """Ghostty config/theme files: `key = value`, `#` comments. Keys repeat."""
    out = []
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" not in line:
                continue
            k, v = line.split("=", 1)
            out.append((k.strip(), v.strip()))
    return out


def color(hexstr):
    h = hexstr.lstrip("#")
    r, g, b = (int(h[i:i + 2], 16) / 255.0 for i in (0, 2, 4))
    return {
        "Red Component": r,
        "Green Component": g,
        "Blue Component": b,
        "Alpha Component": 1.0,
        "Color Space": "sRGB",
    }


cfg = dict(parse_kv(GHOSTTY_CONFIG))
theme_path = os.path.join(THEME_DIR, cfg.get("theme", "Gruvbox Dark"))
if not os.path.exists(theme_path):
    sys.exit(f"theme not found: {theme_path}")

profile = {
    "Name": "Ghostty",
    "Guid": GUID,
    # Inherit everything not named here from the Default profile.
    "Dynamic Profile Parent Name": "Default",
}

# --- colors -----------------------------------------------------------------
# One scheme for both appearances, like Ghostty.
profile["Use Separate Colors for Light and Dark Mode"] = False
for k, v in parse_kv(theme_path):
    if k == "palette":
        idx, val = v.split("=", 1)
        profile[f"Ansi {int(idx)} Color"] = color(val)
    elif k == "background":
        profile["Background Color"] = color(v)
    elif k == "foreground":
        profile["Foreground Color"] = color(v)
        profile["Bold Color"] = color(v)
    elif k == "cursor-color":
        profile["Cursor Color"] = color(v)
    elif k == "cursor-text":
        profile["Cursor Text Color"] = color(v)
    elif k == "selection-background":
        profile["Selection Color"] = color(v)
    elif k == "selection-foreground":
        profile["Selected Text Color"] = color(v)

# --- font -------------------------------------------------------------------
family = cfg.get("font-family", "JetBrainsMono Nerd Font Mono")
size = cfg.get("font-size", "15")
profile["Normal Font"] = f"{PS_NAMES.get(family, family)} {size}"
profile["Use Non-ASCII Font"] = False

# --- behaviour --------------------------------------------------------------
# Option must stay "Normal": on the Danish layout it composes [ ] { } (same
# reason ghostty/config never sets macos-option-as-alt).
profile["Option Key Sends"] = 0
profile["Right Option Key Sends"] = 0
profile["Unlimited Scrollback"] = True
# confirm-close-surface = false
profile["Prompt Before Closing 2"] = False
profile["Terminal Type"] = "xterm-256color"

# --- keyboard ---------------------------------------------------------------
# Action 10 = send ESC + Text, Action 11 = send hex bytes.
keymap = {}

# 1. Ghostty's five built-in text keybinds (`ghostty +list-keybinds --default`):
#    cmd+left/right = ^A/^E, cmd+backspace = ^U, alt+left/right = ESC b/f.
#    Identical to iTerm's "Natural Text Editing" preset, plus its alt+backspace
#    and fn+delete entries. Profile mappings beat iTerm's global ones, so these
#    win over the default cmd+arrow = switch tab.
keymap.update({
    "0xf702-0x300000": {"Action": 11, "Text": "0x1"},        # cmd+left  -> ^A
    "0xf703-0x300000": {"Action": 11, "Text": "0x5"},        # cmd+right -> ^E
    "0x7f-0x100000":   {"Action": 11, "Text": "0x15"},       # cmd+bksp  -> ^U
    "0xf702-0x280000": {"Action": 10, "Text": "b"},          # alt+left  -> ESC b
    "0xf703-0x280000": {"Action": 10, "Text": "f"},          # alt+right -> ESC f
    "0x7f-0x80000":    {"Action": 11, "Text": "0x1b 0x7f"},  # alt+bksp  -> del word
    "0xf728-0x0":      {"Action": 11, "Text": "0x4"},        # fn+delete
    "0xf728-0x80000":  {"Action": 10, "Text": "d"},          # alt+fn+delete
})

# 2. herdr's switch_tab = cmd+ctrl+1..9. Verified 2026-09-11: iTerm implements
#    the kitty keyboard protocol (ctrl+alt+* and ctrl+shift+* arrive correctly
#    on their own), but it swallows cmd chords entirely — nothing reaches the
#    tty. So encode them by hand: CSI <codepoint>;13u, where 13 = 1 + ctrl(4) +
#    super(8) in the kitty modifier encoding.
for digit in range(1, 10):
    codepoint = ord(str(digit))
    keymap[f"0x{codepoint:x}-0x140000"] = {  # cmd(0x100000) + ctrl(0x40000)
        "Action": 10,
        "Text": f"[{codepoint};13u",
    }

profile["Keyboard Map"] = keymap

os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, "w") as f:
    json.dump({"Profiles": [profile]}, f, indent=2, sort_keys=True)
    f.write("\n")
print("wrote", OUT)
