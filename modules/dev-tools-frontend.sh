#!/usr/bin/env bash

### BEGIN Node.js
which node > /dev/null
if [[ "${?}" == "1" ]]; then
  curl --silent --location https://deb.nodesource.com/setup_12.x | sudo -E bash -
  sudo apt install --yes nodejs
fi
### END Node.js

### BEGIN Yarn
which yarn > /dev/null
if [[ "${?}" == "1" ]]; then
  curl --silent --location https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

  sudo apt update && sudo apt install --yes yarn

  for FILE in ~/.bashrc ~/.zshrc; do
    grep -E 'export.*yarn\/bin' "${FILE}" --quiet
    if [[ "${?}" == "1" ]]; then
      echo "export PATH=\"\$PATH:$(yarn global bin)\"" | tee --append "${FILE}"
    fi
  done
fi
### END Yarn

