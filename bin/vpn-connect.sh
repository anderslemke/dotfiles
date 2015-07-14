#!/usr/bin/env bash

if [ ${#1} = 0 ]
then
  PARK='all';
else
  if [ "$1" == "15" ] || [ "$1" == "16" ]; then
    PARK="albertslund";
  else
    PARK="soborg";
  fi
fi

if [ "$PARK" == "all" ] ; then
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "FF-vpn Glasvej"
                if exists VPN then connect VPN
                repeat while (current configuration of VPN is not connected)
                    delay 1
                end repeat
        end tell
end tell
EOF
fi
if [ "$PARK" == "all" ] || [ "$PARK" == "albertslund" ] ; then
  /usr/bin/env osascript <<-EOF
  tell application "System Events"
          tell current location of network preferences
                  set VPN to service "FF-vpn Albertslund"
                  if exists VPN then connect VPN
                  repeat while (current configuration of VPN is not connected)
                      delay 1
                  end repeat
          end tell
  end tell
EOF
fi
if [ "$PARK" == "all" ] || [ "$PARK" == "soborg" ] ; then
  /usr/bin/env osascript <<-EOF
  tell application "System Events"
          tell current location of network preferences
                  set VPN to service "FF-vpn Søborg"
                  if exists VPN then connect VPN
                  repeat while (current configuration of VPN is not connected)
                      delay 1
                  end repeat
          end tell
  end tell
EOF
fi
