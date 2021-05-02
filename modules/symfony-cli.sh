#!/usr/bin/env bash

if ! which symfony > /dev/null; then
    curl --silent --show-error https://get.symfony.com/cli/installer | bash
fi

for FILE in ~/.bashrc ~/.zshrc; do
    if ! grep --quiet "export PATH=\"\$HOME/.symfony/bin:\$PATH\"" "${FILE}"; then
        echo "export PATH=\"\$HOME/.symfony/bin:\$PATH\"" | tee --append "${FILE}"
    fi
done