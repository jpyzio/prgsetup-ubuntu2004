#!/usr/bin/env bash

RC_FILE="${USER_HOME}/.zshrc"
OH_FILE="${USER_HOME}/.oh-my-zsh"

if [[ ! -d "${OH_FILE}" ]]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git "${OH_FILE}"
    cat "${USER_HOME}/.oh-my-zsh/templates/zshrc.zsh-template" >> "${RC_FILE}"
    chown "${USER_NAME}". "${RC_FILE}"
    chsh --shell /bin/zsh
fi