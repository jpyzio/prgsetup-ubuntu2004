#!/usr/bin/env bash

sudo curl --location "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname --kernel-name)-$(uname --machine)" --output /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
sudo ln --symbolic /usr/local/bin/docker-compose /usr/bin/docker-compose
