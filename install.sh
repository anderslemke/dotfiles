ln -is ~/dotfiles/.vimrc ~/.vimrc
ln -Fnis ~/dotfiles/.vim ~/.vim
ln -is ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -is ~/dotfiles/.gitconfig ~/.gitconfig
ln -is ~/dotfiles/.ssh/config ~/.ssh/config
ln -Fnis ~/dotfiles/.tmuxinator ~/.tmuxinator
ln -is ~/dotfiles/.editrc ~/.editrc
ln -is ~/dotfiles/.inputrc ~/.inputrc
ln -is ~/dotfiles/.bashrc ~/.bashrc
ln -is ~/dotfiles/.tigrc ~/.tigrc
ln -is ~/dotfiles/.irbrc ~/.irbrc

mkdir -p ~/.config/nvim
ln -is ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -is ~/dotfiles/nvim/pack ~/.config/nvim/pack

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
