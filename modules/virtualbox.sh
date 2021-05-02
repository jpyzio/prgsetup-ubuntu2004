#!/usr/bin/env bash

apt install --yes virtualbox virtualbox-ext-pack

if ! groups | grep --quiet vboxusers; then
    adduser "${USER_NAME}" vboxusers
fi