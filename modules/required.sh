#!/usr/bin/env bash

### BEGIN Required
sudo apt update
sudo apt full-upgrade --yes

sudo apt install --yes gdebi curl wget jq zenity rng-tools xclip gawk \
  software-properties-common apt-transport-https ca-certificates gnupg-agent

sudo apt autoremove --yes
sudo apt autoclean --yes
### END Required
