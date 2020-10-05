#!/usr/bin/env bash

curl --silent --show-error https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

for FILE in ~/.bashrc ~/.zshrc; do
  grep "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" "${FILE}" --quiet
  if [[ "${?}" == "1" ]]; then
    echo "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" | tee --append "${FILE}"
  fi
done