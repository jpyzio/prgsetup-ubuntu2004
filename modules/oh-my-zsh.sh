#!/usr/bin/env bash

if [[ ! -d ~/.oh-my-zsh ]]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cat ~/.oh-my-zsh/templates/zshrc.zsh-template | tee --append ~/.zshrc
    sudo chsh --shell /bin/zsh
fi