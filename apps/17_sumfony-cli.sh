#!/usr/bin/env bash

which symfony > /dev/null
if [[ "${?}" == "1" ]]; then
  curl --silent --show-error https://get.symfony.com/cli/installer | bash
fi

for FILE in ~/.bashrc ~/.zshrc; do
  grep "export PATH=\"\$HOME/.symfony/bin:\$PATH\"" "${FILE}" --quiet
  if [[ "${?}" == "1" ]]; then
    echo "export PATH=\"\$HOME/.symfony/bin:\$PATH\"" | tee --append "${FILE}"
  fi
done