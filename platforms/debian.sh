apt-get install -y wajig
apt-get install -y ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
wajig install -y tig
~/dotfiles/platforms/compile_tmux.sh
