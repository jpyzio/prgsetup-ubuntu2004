#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."

cd "${ROOT_DIR}"

which git > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo apt install git
fi

git pull
