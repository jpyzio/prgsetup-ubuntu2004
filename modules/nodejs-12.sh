#!/usr/bin/env bash

which node > /dev/null
if [[ "${?}" == "1" ]]; then
    curl --silent --location https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt install --yes nodejs
fi