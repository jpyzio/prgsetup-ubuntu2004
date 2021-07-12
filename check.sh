#!/usr/bin/env bash

set -o pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

if [[ -z "${UPDATE_PERIOD}" ]]; then
  UPDATE_PERIOD=7
fi

if [[ ! -f "${ROOT_DIR}/.last_update" || "$((($(date +%s) - $(cat "${ROOT_DIR}/.last_update")) / 86400))" -gt "${UPDATE_PERIOD}" ]] ; then
    echo 'Update your system or press CTRL+C'
    sudo "${ROOT_DIR}/run.sh" update
fi
