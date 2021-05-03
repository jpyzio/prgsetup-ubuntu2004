#!/usr/bin/env bash

for FILE in ${USER_HOME}/.bashrc ${USER_HOME}/.zshrc; do
    if ! grep --quiet -E "source.*aliases.sh" "${FILE}"; then
        echo "source \"${ROOT_DIR}/aliases.sh\"" >> "${FILE}"
        chown "${USER_NAME}". "${FILE}"
    fi
done
