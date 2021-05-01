#!/usr/bin/env bash

if ! which symfony > /dev/null; then
    curl --silent --show-error https://get.symfony.com/cli/installer | bash
fi

EXPORT_PATH="export PATH=\"\$HOME/.symfony/bin:\$PATH\""

for FILE in ~/.bashrc ~/.zshrc; do
    if ! grep --quiet "${EXPORT_PATH}" "${FILE}"; then
        echo "${EXPORT_PATH}" >> "${FILE}"
        chown "$(logname)". "${FILE}"
    fi
done
