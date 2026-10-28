// ObsidianLink — a URL handler that turns ipns:// into obsidian://
//
// Ghostty only makes links clickable for a hardcoded list of schemes, and it
// filters OSC 8 hyperlinks on the same list. obsidian:// isn't on it; ipns://
// is, and has no handler on macOS, so we borrow it.
// See dotfiles/CLAUDE.md → "Ghostty clickable links".
//
// Runs as an accessory app: no Dock tile, no app switcher entry, just a small
// menu bar icon so the thing isn't invisible. Stays resident once launched, so
// later links open without the startup delay.

import AppKit

let kScheme = "ipns://"

func log(_ msg: String) {
    let line = "\(Date()) \(msg)\n"
    let path = "/tmp/obsidianlink.log"
    if let h = FileHandle(forWritingAtPath: path) {
        h.seekToEndOfFile(); h.write(line.data(using: .utf8)!); h.closeFile()
    } else {
        try? line.write(toFile: path, atomically: true, encoding: .utf8)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var lastOpened: String = "—"

    func forward(_ raw: String) {
        log("got: \(raw)")
        guard raw.hasPrefix(kScheme) else { log("wrong scheme"); return }
        let rest = String(raw.dropFirst(kScheme.count))
        guard let url = URL(string: "obsidian://" + rest) else { log("bad url"); return }
        log("-> \(url.absoluteString)")
        lastOpened = rest.removingPercentEncoding ?? rest
        NSWorkspace.shared.open(url)
        rebuildMenu()
    }

    // Modern path: LaunchServices hands URLs straight to the delegate.
    func application(_ application: NSApplication, open urls: [URL]) {
        urls.forEach { forward($0.absoluteString) }
    }

    // Fallback: the classic GURL Apple Event.
    @objc func handleGetURL(_ event: NSAppleEventDescriptor, reply: NSAppleEventDescriptor) {
        if let s = event.paramDescriptor(forKeyword: keyDirectObject)?.stringValue {
            forward(s)
        }
    }

    func rebuildMenu() {
        // May be called from the URL handler before the status item exists.
        guard let statusItem = statusItem else { return }
        let menu = NSMenu()
        let header = NSMenuItem(title: "ObsidianLink — ipns:// → obsidian://", action: nil, keyEquivalent: "")
        header.isEnabled = false
        menu.addItem(header)
        let last = NSMenuItem(title: "Sidst åbnet: \(lastOpened)", action: nil, keyEquivalent: "")
        last.isEnabled = false
        menu.addItem(last)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Afslut", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }

    func applicationDidFinishLaunching(_ note: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "link.circle", accessibilityDescription: "ObsidianLink")
            button.image?.isTemplate = true
        }
        rebuildMenu()
    }
}

let delegate = AppDelegate()
let app = NSApplication.shared
// .accessory = menu bar only: no Dock tile, no Cmd-Tab entry.
app.setActivationPolicy(.accessory)
app.delegate = delegate

// Register BEFORE run(): the URL that launched us can arrive before
// applicationDidFinishLaunching fires.
NSAppleEventManager.shared().setEventHandler(
    delegate,
    andSelector: #selector(AppDelegate.handleGetURL(_:reply:)),
    forEventClass: AEEventClass(kInternetEventClass),
    andEventID: AEEventID(kAEGetURL))

app.run()
