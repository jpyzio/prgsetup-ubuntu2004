#!/usr/bin/env bash

apt install --yes virtualbox virtualbox-ext-pack virtualbox-dkms

if ! groups | grep --quiet vboxusers; then
    adduser "${USER_NAME}" vboxusers
fi
