#!/usr/bin/env bash

if ! which brave-browser > /dev/null; then
    GPG_KEY_PATH=/usr/share/keyrings/brave-browser-archive-keyring.gpg
    GPG_KEY_URL=https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    curl -fsSLo "${GPG_KEY_PATH}" "${GPG_KEY_URL}"

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        > /etc/apt/sources.list.d/brave-browser-release.list

    apt update

    apt install --yes brave-browser
fi
