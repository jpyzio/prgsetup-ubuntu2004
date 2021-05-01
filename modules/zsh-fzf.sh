#!/usr/bin/env bash

if [[ ! -d ~/.fzf ]]; then
    DIR_PATH=~/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git "${DIR_PATH}"
    chown -R $(logname). "${DIR_PATH}"
    ~/.fzf/install --all
fi
