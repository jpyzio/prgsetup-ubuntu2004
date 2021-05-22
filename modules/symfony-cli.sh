#!/usr/bin/env bash

if ! which symfony > /dev/null; then
    curl --silent --show-error https://get.symfony.com/cli/installer | run_as_user bash
else
    symfony self-update
fi

EXPORT_PATH="export PATH=\"\$HOME/.symfony/bin:\$PATH\""

for FILE in "${USER_HOME}/.bashrc" "${USER_HOME}/.zshrc"; do
    if ! grep --quiet "${EXPORT_PATH}" "${FILE}"; then
        echo "${EXPORT_PATH}" >> "${FILE}"
        chown "${USER_NAME}". "${FILE}"
    fi
done
