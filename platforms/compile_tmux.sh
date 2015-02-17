#!/bin/bash

if [[ 'tmux 1.9a' == `tmux -V` ]]
then
  echo 'Version of tmux is great!'
else
  cd
  mkdir src
  cd src
  wget "https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz"

  tar -xf libevent-2.0.21-stable.tar.gz
  cd libevent-2.0.21-stable
  ./configure
  make
  make verify
  sudo make install
  sudo ldconfig
  cd ..
  rm -rf libevent*

  sudo apt-get install libncurses-dev

  wget "http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.9/tmux-1.9a.tar.gz"
  tar xvfz tmux-1.9a.tar.gz
  cd tmux-1.9a/
  ./configure && make
  sudo make install
  cd ..
  rm -rf tmux*
fi


