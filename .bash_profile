# Make sure this file is sourced in ~/.bash_profile
# source ~/dotfiles/.bash_profile
PATH=$PATH:$HOME/dotfiles/bin # Add my own bin to PATH

PATH=$PATH:/usr/local/sbin # Add brew rabbit

# Set ulimit such that I can run tests without garbage collection
ulimit -n 4096

export EDITOR='vim'
source ~/dotfiles/bin/tmuxinator.bash
source ~/dotfiles/bin/zversion.bash
set -o vi

alias vi="vim"
alias vin="vim -u NONE"
alias mux="tmuxinator"

alias so="source ~/.bash_profile"
alias ci="tig status"
alias ca="git commit -a"

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias lal='ls $LS_OPTIONS -al'
alias l='ls $LS_OPTIONS -lA'

alias trr="time (be rspec && be rubocop -l)"

alias p="cd ~/Projects/"
alias contact="cd ~/Projects/contact"
alias fak="cd ~/Projects/fak"
alias be="bundle exec"
alias brake="be rake"
alias srake="spring rake"
alias gg="git grep"
alias t="p;cd weight-loss;vi anders.csv"

alias redsites="open https://zetland.pagerduty.com/incidents; open https://dashboard.heroku.com/apps/zetland-api-production/metrics/web; open https://addons-sso.heroku.com/apps/zetland-api-production/addons/e4b19771-9823-49e6-8b95-8587d0c01852; open https://addons-sso.heroku.com/apps/zetland-api-production/addons/70332e32-6146-4a7f-80e5-254805e2d311;"

# Zetland aliases
alias z="p; cd zetland"
alias mainframe="z; cd mainframe"
alias frontend="z; cd frontend"
alias m="mainframe"
alias f="frontend"
alias lyd="z; cd lyd-react-native"
alias caf="z; cd caf_receiver"

alias shake_android="adb shell input keyevent 82"

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
# export LC_ALL=

# Prompt
#PS1='(\A) \[\e[0;32m\]\W\[\e[0;33m\]$(__git_ps1 " (%s)") \[\e[0;31m\]\$ \[\e[0m\]'
export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\W\[\e[0;33m\]$(__git_ps1 " (%s)") \[\033[01;35m\]\$ \[\033[00m\]'

# Git stuff
source ~/dotfiles/.git-completion.bash
complete -o default -o nospace -F _git_branch gb
complete -o default -o nospace -F _git_checkout gco

ff () {
  # Author: Joshua Toyota (Unix Superhero)
  find . -type f | grep -i "$(echo "$1" | sed 's/./&.*/g')"
}
vff() {
  vim `ff $1 | head -1`
}

# Force terminal not to take control of Ctrl-s
stty -ixon
