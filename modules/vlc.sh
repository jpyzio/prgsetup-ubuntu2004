#!/usr/bin/env bash

which vlc > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo apt-get install --yes vlc
fi