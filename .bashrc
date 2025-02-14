# Git stuff

source ~/dotfiles/.bash_aliases

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

source ~/dotfiles/bin/tmuxinator.bash
source ~/dotfiles/bin/version.bash

alias vi="vim"
alias vin="vim -u NONE"
alias mux="tmuxinator"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"

alias restart_nginx="kill -HUP \`cat /var/run/nginx.pid\`"

alias remote_submit="cd ~/Projects/oasis/oase-app/apps/expo; eas build:version:set -p ios && eas update --auto && eas build --platform ios --non-interactive --auto-submit"
alias submit="cd ~/Projects/oasis/oase-app/apps/expo; eas build:version:set -p ios && eas build --platform ios --local --non-interactive --output ./production.ipa && eas submit -p ios --non-interactive --path=./production.ipa"
alias preview="cd ~/Projects/oasis/oase-app/apps/expo; eas build --platform ios --local --profile preview --non-interactive --output ./preview.ipa && open ."
alias set_version="cd ~/Projects/oasis/oase-app/apps/expo; eas build:version:set -p"
alias submit_android="cd ~/Projects/oasis/oase-app/apps/expo; eas build:version:set -p android && eas build --platform android --local --non-interactive --output ./production.aab && eas submit -p android --non-interactive --path=./production.aab"
alias build_android="cd ~/Projects/oasis/oase-app/apps/expo; eas build:version:set -p android && eas build --platform android --non-interactive && open https://play.google.com/console/u/0/developers/5024103918893709537/app/4975730837800482341/bundle-explorer-selector"

alias so="source ~/.bash_profile"
alias ci="tig status"
alias ca="git commit -a"

alias myip="curl ifconfig.me | pbcopy; echo 'Your IP is copied to your clipboard'"

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias lal='ls $LS_OPTIONS -al'
alias l='ls $LS_OPTIONS -lA'

alias hc='heroku console'

alias trr="time (bundle exec rake parallel:spec)"

alias p="cd ~/Projects/"
alias contact="cd ~/Projects/contact"
alias fak="cd ~/Projects/fak"
alias bilag="cd ~/Projects/bilag"
alias o="cd ~/Projects/oasis"
alias api="cd ~/Projects/oasis/mainframe"
alias app="cd ~/Projects/oasis/oase-app"
alias kms="cd ~/Projects/oasis/kms"

alias be="bundle exec"

alias b="p; cd bryllup"
alias c="p; cd just_chat"

alias redsites="open https://zetland.pagerduty.com/incidents; open https://dashboard.heroku.com/apps/zetland-api-production/metrics/web; open https://addons-sso.heroku.com/apps/zetland-api-production/addons/e4b19771-9823-49e6-8b95-8587d0c01852; open https://addons-sso.heroku.com/apps/zetland-api-production/addons/70332e32-6146-4a7f-80e5-254805e2d311;"

alias life="cd ~/life; vi"

# Zetland aliases
alias m="api"

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

