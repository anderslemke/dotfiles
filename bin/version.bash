#! /bin/bash

function getVersion () {
  echo "$1"
  curl -s $1 | grep -Eo "meta name=\"version\" content=\"(\w*)\"" | grep -Eo "\"(\w*)\"" | cut -d "\"" -f 2
}
export -f getVersion

function version () {
  url=$1
  case $1 in
    launch)
      url=https://launch.zetland.dk/version
      ;;
    api)
      url=https://api.zetland.dk/version
      ;;
    api-staging)
      url=https://api-staging.zetland.dk/version
      ;;
    fak)
      url=https://www.hurtigfaktura.dk/version
      ;;
    fak-staging)
      url=https://hurtigfaktura-staging.herokuapp.com/version
      ;;
    *)
      url=https://www.zetland.dk/version
      ;;
  esac

  v=$(getVersion $url)
  date
  echo $v
  while [ 0 ]; do
    w=$(getVersion $url);
    if [[ $v != $w ]]; then
      date
      date | terminal-notifier -ignoreDnD -title "$url deployed at";
      echo $w
    fi
    v=$w
    sleep 10;
  done;
}
