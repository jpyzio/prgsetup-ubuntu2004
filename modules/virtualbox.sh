#!/usr/bin/env bash

sudo apt install --yes virtualbox virtualbox-ext-pack

if ! groups | grep --quiet vboxusers; then
    sudo adduser "${USER}" vboxusers
fi