#!/usr/bin/env bash

set -o pipefail

apt install --yes gdebi \
    curl \
    wget \
    jq \
    zenity \
    rng-tools \
    xclip \
    gawk \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg-agent

cd "${ROOT_DIR}"
run_as_user git pull
cd -

apt full-upgrade --yes

snap refresh

if which composer > /dev/null; then
    run_as_user composer global update
fi

apt autoremove --yes
apt autoclean --yes
