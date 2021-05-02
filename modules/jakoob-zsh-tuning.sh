#!/usr/bin/env bash

if [[ -f ~/.zshrc ]]; then
    if ! grep --quiet 'forward-word' ~/.zshrc; then
        echo -e "bindkey \"^[[1;3C\" forward-word\nbindkey \"^[[1;3D\" backward-word" | tee --append ~/.zshrc
    fi
fi