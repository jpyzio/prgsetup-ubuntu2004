#!/usr/bin/env bash

LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep "tag_name" | cut -d'v' -f2 | cut -d'"' -f4)
BIN_FILE_URL="https://github.com/docker/compose/releases/download/${LATEST_VERSION}/docker-compose-$(uname --kernel-name)-$(uname --machine)"

curl --location --silent "${BIN_FILE_URL}" --output /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
ln --symbolic --force /usr/local/bin/docker-compose /usr/bin/docker-compose
