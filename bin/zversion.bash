function zversion () {
  if [[ $1 ]]; then
    subdomain=$1
  else
    subdomain=www
  fi
  path=''
  if [[ $subdomain == 'launch' ]]; then
    path='zversion'
  fi
  if [[ $subdomain == 'www' ]]; then
    path='zversion'
  fi
  echo "https://$subdomain.zetland.dk/$path"
  curl -s https://$subdomain.zetland.dk/$path | grep -Eo "meta name=\"zetland-version\" content=\"(\w*)\"" | grep -Eo "\"(\w*)\"" | cut -d "\"" -f 2
}
export -f zversion
function zversionalert () {
  v=$(zversion $1)
  echo $v
  while [ 0 ]; do
    w=$(zversion $1);
    if [[ $v != $w ]]; then
      echo "Deployed $1" | terminal-notifier;
      echo $w
    fi
    v=$w
    sleep 1;
  done;
}
