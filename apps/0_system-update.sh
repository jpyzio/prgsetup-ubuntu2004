#!/usr/bin/env bash

sudo apt full-upgrade --yes

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

sudo snap refresh

which composer > /dev/null
if [[ "${?}" == "0" ]]; then
    curl --silent --show-error https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer

    composer global update
fi
