# Make sure this file is sourced in ~/.bash_profile
# source ~/dotfiles/.bash_profile
PATH=$PATH:$HOME/dotfiles/bin # Add my own bin to PATH

export EDITOR='vim'
source ~/dotfiles/bin/tmuxinator.bash
set -o vi

export FIRMAFON_USER='al'

alias so="source ~/.bash_profile"
alias ci="tig status"
alias ca="git commit -a"

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias lal='ls $LS_OPTIONS -al'
alias l='ls $LS_OPTIONS -lA'

alias p="cd ~/Projects/"
alias contact="cd ~/Projects/contact"
alias fak="cd ~/Projects/fak"
alias be="bundle exec"
alias brake="be rake"
alias gg="git grep"

##### Firmafon aliases #####
alias dummy_jenkins="spring rails g migration jenkins-dummy-anders-`date +%s` && spring rake db:migrate && git add db/migrate && git commit -am 'Jenkins dummy' && git push"
alias mainframe="f; cd mainframe"
alias middle="f; cd middleman"
alias ffpuppet="f; cd puppet"
alias debug="vpn-connect.sh;f; cd debug"
alias q="debug; cap prod q"
alias vitals="debug;cap"
alias partner="f; cd partner"
alias switch="f; cd switch"
alias wallboard="f; cd wallboard"
alias switchdev="f; cd switchdev"
alias angular="f; cd angular-firmafon"
##### Firmafon aliases #####

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
