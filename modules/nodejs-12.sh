#!/usr/bin/env bash

if ! which node > /dev/null; then
    curl --silent --location https://deb.nodesource.com/setup_12.x | bash -
    apt install --yes nodejs
fi
