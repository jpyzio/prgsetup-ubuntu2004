#!/usr/bin/env bash

for FILE in ~/.bashrc ~/.zshrc; do
  grep -E "source.*custom-functions.sh" "${FILE}" --quiet
  if [[ "${?}" == "1" ]]; then
    echo "source \"${ROOT_DIR}/aliases.sh\"" | tee --append "${FILE}"
  fi
done