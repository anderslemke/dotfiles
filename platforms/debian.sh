apt-get install wajig
apt-get install ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
wajig install tig
~/dotfiles/platforms/compile_tmux.sh
