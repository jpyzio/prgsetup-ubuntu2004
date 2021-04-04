#!/usr/bin/env bash

sudo apt install --yes virtualbox virtualbox-ext-pack

groups | grep vboxusers --quiet
if [[ ${?} == "1" ]]; then
    sudo adduser $USER vboxusers
fi