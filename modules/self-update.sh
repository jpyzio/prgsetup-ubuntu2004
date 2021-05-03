#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."

# shellcheck disable=SC2164
cd "${ROOT_DIR}"

which git > /dev/null
if [[ "${?}" == "1" ]]; then
    apt install git
fi

git pull
