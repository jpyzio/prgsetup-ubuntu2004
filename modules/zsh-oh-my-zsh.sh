#!/usr/bin/env bash

RC_FILE="${USER_HOME}/.zshrc"
OH_FILE="${USER_HOME}/.oh-my-zsh"

if [[ ! -d "${OH_FILE}" ]]; then
    run_as_user git clone https://github.com/robbyrussell/oh-my-zsh.git "${OH_FILE}"
    run_as_user mv "${RC_FILE}" "${RC_FILE}-backup"
    echo -e "\e[33mThe ~/.zshrc backup is here: ${RC_FILE}-backup \e[39m"
    run_as_user cp "${USER_HOME}/.oh-my-zsh/templates/zshrc.zsh-template" "${RC_FILE}"
fi
