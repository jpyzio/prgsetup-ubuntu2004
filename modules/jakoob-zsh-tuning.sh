#!/usr/bin/env bash

if [[ -f ~/.zshrc ]]; then
    grep 'forward-word' ~/.zshrc
    if [[ "${?}" == "1" ]]; then
        echo -e "bindkey \"^[[1;3C\" forward-word\nbindkey \"^[[1;3D\" backward-word" | tee --append ~/.zshrc
    fi
fi