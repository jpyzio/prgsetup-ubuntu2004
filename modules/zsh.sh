#!/usr/bin/env bash

if ! which zsh > /dev/null; then
    apt install --yes zsh
    chsh --shell /bin/zsh
fi