#!/usr/bin/env bash
set -o pipefail

UPDATE_DAYS=1
UPDATE_SEC=$((${UPDATE_DAYS}*3600*24))

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${ROOT_DIR}/modules"

LAST_UPDATE_FILE="${ROOT_DIR}/.last_update"
CURRENT_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

if [[ ! -f "${LAST_UPDATE_FILE}" ]]; then
	echo "${CURRENT_TIMESTAMP}" > "${LAST_UPDATE_FILE}"
    echo "${BASH_SOURCE[0]}" | tee --append ~/.zshrc ~/.bashrc
    exit
fi

LAST_UPDATE_TIME=$(date -d "$(cat ${LAST_UPDATE_FILE})" +%s)
CURRENT_TIME=$(date -d "${CURRENT_TIMESTAMP}" +%s)
SEC_SINCE_UPDATE=$((CURRENT_TIME-LAST_UPDATE_TIME))

if (( "${SEC_SINCE_UPDATE}" < "${UPDATE_SEC}" )); then
    exit
fi

read -p "Do you want to update your system and other tools? [y/N]" -n 1 -r
echo
if [[ "${REPLY}" =~ ^[YyTt]$ ]]; then
	sudo apt full-upgrade --yes
	sudo snap refresh

	which composer > /dev/null
	if [[ "${?}" == "0" ]]; then
	    "${MODULES_DIR}/composer.sh"
	    composer global update
	fi

    sudo apt autoremove --yes
	sudo apt autoclean --yes

    echo "${CURRENT_TIMESTAMP}" > "${LAST_UPDATE_FILE}"
fi
