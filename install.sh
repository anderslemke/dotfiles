ln -is ~/dotfiles/vimrc ~/.vimrc
ln -Fnis ~/dotfiles/vim ~/.vim
ln -is ~/dotfiles/tmux.conf ~/.tmux.conf
ln -is ~/dotfiles/.gitconfig ~/.gitconfig
ln -is ~/dotfiles/.ssh/config ~/.ssh/config
ln -Fnis ~/dotfiles/.tmuxinator ~/.tmuxinator
ln -is ~/dotfiles/.editrc ~/.editrc
ln -is ~/dotfiles/.inputrc ~/.inputrc
vim +PlugInstall +qall
echo '==============================='
echo 'Make sure to add something like'
echo ''
echo 'alias f="cd ~/projects"'
echo 'source ~/dotfiles/.bash_profile'
echo ''
echo 'to your ~/.bash_profile'
echo '==============================='


echo '==============================='
echo 'Make sure to add the folliwing to'
echo 'vi /Applications/GitHub.app/Contents/Resources/git/share/git-core/templates/info/exclude'
echo ''
echo 'doc/tag'
echo 'doc/tag-ja'
echo ''
echo 'This is your current file:'
cat /Applications/GitHub.app/Contents/Resources/git/share/git-core/templates/info/exclude
echo '==============================='
