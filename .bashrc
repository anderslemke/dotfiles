# Git stuff

source ~/dotfiles/.bash_aliases

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

source ~/dotfiles/bin/tmuxinator.bash
source ~/dotfiles/bin/version.bash

alias vi="vim"
alias vin="vim -u NONE"
alias mux="tmuxinator"

alias restart_nginx="kill -HUP \`cat /var/run/nginx.pid\`"

alias so="source ~/.bash_profile"
alias ci="tig status"
alias ca="git commit -a"

alias myip="curl ifconfig.me | pbcopy; echo 'Your IP is copied to your clipboard'"

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias lal='ls $LS_OPTIONS -al'
alias l='ls $LS_OPTIONS -lA'

alias hc='heroku run bash -ic "wget https://raw.github.com/anderslemke/dotfiles/master/.inputrc;ALL_THE_USERS=\"\" bin/rails c"'

alias trr="time (bundle exec rake parallel:spec)"

alias p="cd ~/Projects/"
alias contact="cd ~/Projects/contact"
alias fak="cd ~/Projects/fak"
alias bilag="cd ~/Projects/bilag"
alias be="bundle exec"

alias b="p; cd bryllup"
alias c="p; cd just_chat"

alias redsites="open https://zetland.pagerduty.com/incidents; open https://dashboard.heroku.com/apps/zetland-api-production/metrics/web; open https://addons-sso.heroku.com/apps/zetland-api-production/addons/e4b19771-9823-49e6-8b95-8587d0c01852; open https://addons-sso.heroku.com/apps/zetland-api-production/addons/70332e32-6146-4a7f-80e5-254805e2d311;"

alias life="cd ~/life; vi"

# Zetland aliases
alias z="p; cd zetland"
alias mainframe="z; cd mainframe"
alias frontend="z; cd frontend;nvm use"
alias m="mainframe"
alias f="frontend"
alias lyd="z; cd lyd-react-native; nvm use"
alias caf="z; cd caf_receiver"

alias bitbar="cd; cd dotfiles/bitbar;vi"

alias shake_android="adb shell input keyevent 82"
alias open_android="adb shell am start -d"

source ~/dotfiles/.git-completion.bash
complete -o default -o nospace -F _git_branch gb
complete -o default -o nospace -F _git_checkout gco

# Prompt
#PS1='(\A) \[\e[0;32m\]\W\[\e[0;33m\]$(__git_ps1 " (%s)") \[\e[0;31m\]\$ \[\e[0m\]'
export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\W\[\e[0;33m\]$(__git_ps1 " (%s)") \[\033[01;35m\]\$ \[\033[00m\]'

# Force terminal not to take control of Ctrl-s
stty -ixon

ff () {
  # Author: Joshua Toyota (Unix Superhero)
  find . -type f | grep -i "$(echo "$1" | sed 's/./&.*/g')"
}
vff() {
  vim `ff $1 | head -1`
}

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

