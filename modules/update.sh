#!/usr/bin/env bash

set -o pipefail


sudo apt install --yes gdebi \
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
git pull
cd -

sudo apt full-upgrade --yes

sudo snap refresh

which composer > /dev/null
if [[ "${?}" == "0" ]]; then
    "${MODULES_DIR}/composer.sh"
    composer global update
fi

sudo apt autoremove --yes
sudo apt autoclean --yes
