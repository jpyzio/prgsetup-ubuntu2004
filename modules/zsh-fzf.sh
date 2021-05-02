#!/usr/bin/env bash

DIR_PATH="${USER_HOME}/.fzf"
if [[ ! -d "${DIR_PATH}" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "${DIR_PATH}"
    chown -R "${USER_NAME}". "${DIR_PATH}"
    "${USER_HOME}/.fzf/install" --all
fi
