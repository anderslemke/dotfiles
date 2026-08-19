ln -is ~/dotfiles/.vimrc ~/.vimrc
ln -Fnis ~/dotfiles/.vim ~/.vim
ln -is ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -is ~/dotfiles/.gitconfig ~/.gitconfig
ln -is ~/dotfiles/.ssh/config ~/.ssh/config
ln -Fnis ~/dotfiles/.tmuxinator ~/.tmuxinator
# XDG path too: tmuxinator prefers ~/.config/tmuxinator if it exists, and
# `tmuxinator open/new` looks ONLY there — a stray real dir hijacks it.
ln -Fnis ~/dotfiles/.tmuxinator ~/.config/tmuxinator
ln -is ~/dotfiles/.editrc ~/.editrc
ln -is ~/dotfiles/.inputrc ~/.inputrc
ln -is ~/dotfiles/.bashrc ~/.bashrc
ln -is ~/dotfiles/.tigrc ~/.tigrc
ln -is ~/dotfiles/.irbrc ~/.irbrc

# Tuna picks up scripts from ~/Library/Scripts (see CLAUDE.md)
ln -is ~/dotfiles/bin/ulid2uuid ~/Library/Scripts/ulid2uuid

mkdir -p ~/.config/nvim
ln -is ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -is ~/dotfiles/nvim/pack ~/.config/nvim/pack

mkdir -p ~/.config/ghostty ~/.config/herdr
ln -is ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -is ~/dotfiles/herdr/config.toml ~/.config/herdr/config.toml

vim +PlugClean +PlugInstall +PlugUpdate +qall
~/dotfiles/platforms/install.rb
echo '==============================='
echo 'Make sure to add something like'
echo ''
echo 'alias f="cd ~/projects"'
echo 'source ~/dotfiles/.bash_profile'
echo ''
echo 'to your ~/.bash_profile'
echo '==============================='
