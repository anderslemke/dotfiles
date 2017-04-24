function zversion () {
  if [[ $1 ]]; then
    subdomain=$1
  else
    subdomain=www
  fi
  echo "https://$subdomain.zetland.dk"
  curl -s https://$subdomain.zetland.dk/ | grep -Eo "VERSION = \"(.*)\"" | grep -Eo "\"(.*)\"" | cut -d "\"" -f 2
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
