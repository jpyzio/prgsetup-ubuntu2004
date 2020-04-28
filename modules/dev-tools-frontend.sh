#!/usr/bin/env bash

### BEGIN Node.js
curl --silent --location https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install --yes nodejs
### END Node.js

### BEGIN Yarn
curl --silent --location https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update && sudo apt install --yes yarn

echo "export PATH=\"\$PATH:$(yarn global bin)\"" >>~/.bashrc >>~/.zshrc
### END Yarn

### BEGIN Vue.js
yarn global add @vue/cli
### END Vue.js
