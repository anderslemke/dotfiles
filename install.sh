ln -is ~/dotfiles/vimrc ~/.vimrc
ln -Fnis ~/dotfiles/vim ~/.vim
ln -is ~/dotfiles/tmux.conf ~/.tmux.conf
ln -is ~/dotfiles/.gitconfig ~/.gitconfig
ln -Fnis ~/dotfiles/.tmuxinator ~/.tmuxinator
echo '==============================='
echo 'Make sure to add'
echo 'source ~/dotfiles/.bash_profile'
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
