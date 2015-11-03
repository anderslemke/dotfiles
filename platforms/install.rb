#!/usr/bin/env ruby

if `uname -a` =~ /Debian/
  puts 'Running Debian specific installs'
  `~/dotfiles/platforms/debian.sh`
elsif `uname -a` =~ /Darwin/
  puts 'Running Darwin specific installs'
  `~/dotfiles/platforms/darwin.sh`
else
  puts 'No specific platform commands ran.'
end
