function zversion () {
  if [[ $1 ]]; then
    subdomain=$1
  else
    subdomain=www
  fi
  path=''
  if [[ $subdomain == 'launch' ]]; then
    path='hello'
  fi
  if [[ $subdomain == 'www' ]]; then
    path='hello'
  fi
  echo "https://$subdomain.zetland.dk/$path"
  curl -s https://$subdomain.zetland.dk/$path | grep -Eo "VERSION = \"(.*)\"" | grep -Eo "\"(.*)\"" | cut -d "\"" -f 2
}
export -f zversion
function zversionalert () {
  v=$(zversion $1)
  while [ 0 ]; do
    w=$(zversion $1);
    echo $w
    if [[ $v != $w ]]; then
      flash_screen.applescript;
    else
      v=$w
    fi
    sleep 5;
  done;
}
