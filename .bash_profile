# Make sure this file is sourced in ~/.bash_profile
# source ~/dotfiles/.bash_profile
source ~/dotfiles/.bashrc
PATH=$PATH:$HOME/dotfiles/bin # Add my own bin to PATH

PATH=$PATH:/usr/local/sbin # Add brew rabbit

# Set ulimit such that I can run tests without garbage collection
ulimit -n 4096

export EDITOR='vim'
set -o vi

# Bash mods
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

export TERM="screen-256color"

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"


