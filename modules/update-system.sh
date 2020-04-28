#!/usr/bin/env bash

### BEGIN System update
sudo apt update

sudo apt full-upgrade --yes

sudo apt autoremove --yes

sudo apt autoclean --yes
### END System update
