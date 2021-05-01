#!/usr/bin/env bash

for FILE in ~/.bashrc ~/.zshrc; do
    if ! grep --quiet -E "source.*aliases.sh" "${FILE}"; then
        echo "source \"${ROOT_DIR}/aliases.sh\"" > "${FILE}"
        chown "$(logname)". "${FILE}"
    fi
done
