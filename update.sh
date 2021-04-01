#!/usr/bin/env bash

set -o pipefail

UPDATE_DAYS=1
UPDATE_SEC=$((${UPDATE_DAYS}*3600*24))

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${ROOT_DIR}/modules"

LAST_UPDATE_FILE="${ROOT_DIR}/.last_update"
CURRENT_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

if [[ ! -f "${LAST_UPDATE_FILE}" ]]; then
	echo "${MODULES_DIR}/update.sh" | tee --append ~/.zshrc ~/.bashrc
	exit
fi

LAST_UPDATE_TIME=$(date -d "$(cat ${LAST_UPDATE_FILE})" +%s)
CURRENT_TIME=$(date -d "${CURRENT_TIMESTAMP}" +%s)
SEC_SINCE_UPDATE=$((CURRENT_TIME-LAST_UPDATE_TIME))

if (( "${SEC_SINCE_UPDATE}" < "${UPDATE_DAYS}" )); then
	exit
fi

read -p "Do you want to update your system and other tools? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[YyTt]$ ]]; then
    source "${MODULES_DIR}/system-update.sh"

echo "${CURRENT_TIMESTAMP}" > "${LAST_UPDATE_FILE}"
fi
