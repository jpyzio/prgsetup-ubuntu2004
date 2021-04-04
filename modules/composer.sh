#!/usr/bin/env bash

which php > /dev/null
if [[ "${?}" == "1" ]]; then
	source "${MODULES_DIR}/php7.4-with-extensions.sh"
fi

curl --silent --show-error https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

for FILE in ~/.bashrc ~/.zshrc; do
  grep "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" "${FILE}" --quiet
  if [[ "${?}" == "1" ]]; then
    echo "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" | tee --append "${FILE}"
  fi
done