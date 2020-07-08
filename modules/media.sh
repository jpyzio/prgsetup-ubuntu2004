#!/usr/bin/env bash

### BEGIN Media
which vlc > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo apt-get install --yes vlc
fi

which spotify > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo snap install spotify
fi
### END Media
