brew install tmux
brew install ack
brew install tig
brew install iterm2
brew install 1password
brew install alfred
brew install tuple
brew install rectangle
brew install chruby
brew install ruby-install
brew install nvm
brew install neovim
brew install gitmoji
brew install nativefier
brew uninstall --ignore-dependencies node

# lo0 alias 10.0.2.2 — lets the Android emulator reach host's localhost API.
# Installed as a LaunchDaemon so it survives reboots.
LO0_PLIST=/Library/LaunchDaemons/local.lo0.alias.plist
sudo cp ~/dotfiles/LaunchDaemons/local.lo0.alias.plist "$LO0_PLIST"
sudo chown root:wheel "$LO0_PLIST"
sudo chmod 644 "$LO0_PLIST"
sudo launchctl load -w "$LO0_PLIST"

