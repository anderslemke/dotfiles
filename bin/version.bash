#! /bin/bash

# function getVersion () {
#   curl -s $1 | grep -Eo "meta name=\"version\" content=\"(\w*)\"" | grep -Eo "\"(\w*)\"" | tail -n 1 | cut -d "\"" -f 2
# }

function getVersion () {
  curl -s $1 | jq -r '.version'
}


export -f getVersion

function version () {
  url=$1
  if [[ $url != '' ]]; then
    case $1 in
      launch)
        url=https://launch.zetland.dk/version
        pipeline=https://dashboard.heroku.com/pipelines/f1d7ffbf-4ba3-461c-aabd-b5a6409c044e
        ;;
      api)
        url=https://api.oase.app
        pipeline=https://dashboard.heroku.com/pipelines/5f00e674-4e60-401a-8d11-1bd0f5f87be1
        ;;
      api-staging)
        url=https://api-staging.zetland.dk/version
        pipeline=https://dashboard.heroku.com/pipelines/5f00e674-4e60-401a-8d11-1bd0f5f87be1
        ;;
      fak)
        url=https://www.hurtigfaktura.dk/version
        pipeline=https://dashboard.heroku.com/pipelines/f73f986f-d3b1-4549-b72e-3c4bb1c52ff1
        ;;
      fak-staging)
        url=https://hurtigfaktura-staging.herokuapp.com/version
        pipeline=https://dashboard.heroku.com/pipelines/f73f986f-d3b1-4549-b72e-3c4bb1c52ff1
        ;;
      www)
        url=https://www.zetland.dk/version
        pipeline=https://dashboard.heroku.com/pipelines/f1d7ffbf-4ba3-461c-aabd-b5a6409c044e
        ;;
    esac

    v=$(getVersion $url)
    date
    echo "$url has version $v"
    while [ 0 ]; do
      w=$(getVersion $url);
      if [[ $v != $w ]]; then
        echo "Deployed ${w:0:7} at `date "+%H:%M:%S"`" | terminal-notifier -title "$url" -open "$pipeline"
        echo $w
      fi
      v=$w
      sleep 10;
    done;
  else
    echo "Usage: version [www|launch|api|api-staging|fak|fak-staging]"
  fi
}
