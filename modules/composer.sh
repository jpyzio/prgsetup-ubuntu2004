#!/usr/bin/env bash

if ! which php > /dev/null; then
    source "${MODULES_DIR}/php7.4-with-extensions.sh"
fi

curl --silent --show-error https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

for FILE in ~/.bashrc ~/.zshrc; do
    if ! grep --quiet "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" "${FILE}"; then
        echo "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" | tee --append "${FILE}"
    fi
done