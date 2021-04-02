#!/usr/bin/env bash

LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep "tag_name" | cut -d'v' -f2 | cut -d'"' -f4)

sudo curl --location "https://github.com/docker/compose/releases/download/${LATEST_VERSION}/docker-compose-$(uname --kernel-name)-$(uname --machine)" --output /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
sudo ln --symbolic /usr/local/bin/docker-compose /usr/bin/docker-compose
