#!/usr/bin/env bash

if ! which php > /dev/null; then
    source "${MODULES_DIR}/php7.4-with-extensions.sh"
fi

EXPORT_PATH="export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\""

curl --silent --show-error https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

for FILE in ${USER_HOME}/.bashrc ${USER_HOME}/.zshrc; do
    if ! grep --quiet "${EXPORT_PATH}" "${FILE}"; then
        echo "${EXPORT_PATH}" >> "${FILE}"
        chown "${USER_NAME}". "${FILE}"
    fi
done
