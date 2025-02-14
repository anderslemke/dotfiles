tell application "Safari"
     repeat with i from 1 to the count of windows
          set this_win to (window i)
          repeat with j from 1 to the count of every tab in this_win     
               do JavaScript "window.location.reload()" in (tab j of window i)
          end repeat
     end repeat
end tell


