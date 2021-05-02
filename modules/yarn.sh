#!/usr/bin/env bash

if ! which yarn > /dev/null; then
    curl --silent --location https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

    apt update && apt install --yes yarn

    for FILE in "${USER_HOME}/.bashrc" "${USER_HOME}/.zshrc"; do
        if ! grep --quiet -E 'export.*yarn\/bin' "${FILE}"; then
            echo "export PATH=\"\$PATH:$(yarn global bin)\"" >> "${FILE}"
            chown "${USER_NAME}". "${FILE}"
        fi
    done
fi
