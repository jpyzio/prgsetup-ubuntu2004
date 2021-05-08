#!/usr/bin/env bash

RC_FILE="${USER_HOME}/.zshrc"
OH_DIR="${USER_HOME}/.oh-my-zsh"

if [[ ! -d "${OH_DIR}" ]]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git "${OH_DIR}"
    chown -R "${USER_NAME}". "${OH_DIR}"

    echo -e "\e[33mThe ~/.zshrc backup is here: ${RC_FILE}-backup \e[39m"
    run_as_user mv "${RC_FILE}" "${RC_FILE}-backup"
    run_as_user cp "${USER_HOME}/.oh-my-zsh/templates/zshrc.zsh-template" "${RC_FILE}"
fi
