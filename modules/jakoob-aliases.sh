#!/usr/bin/env bash

for FILE in ~/.bashrc ~/.zshrc; do
    if ! grep -E "source.*aliases.sh" "${FILE}" --quiet; then
        echo "source \"${ROOT_DIR}/aliases.sh\"" | tee --append "${FILE}"
    fi
done
