#!/usr/bin/env ruby

if `uname -a` =~ /Debian/
  puts 'Running Debian specific installs'
  `~/dotfiles/platforms/debian.sh`
else
  puts 'No specific platform commands ran.'
end
