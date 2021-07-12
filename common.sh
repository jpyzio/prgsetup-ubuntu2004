#!/usr/bin/env bash
set -o pipefail

SHOULD_REBOOT=false
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${ROOT_DIR}/modules"
USER_NAME="$(logname)"
USER_HOME="$(eval echo ~"${USER_NAME}")"

run_as_user() {
    sudo -i -H -u "${USER_NAME}" "${@}"
}

text_input() {
    zenity --entry --title="Ubuntu Configurator" --text="${1}"
}

password_input() {
    zenity --password --title="Ubuntu Configurator" --text="${1}"
}

function is_installed() {
    if [[ "${INSTALATION_PROFILE}" == "custom-zero" ]]; then
        echo "off"
        return
    fi

    if [[ ! -f "${ROOT_DIR}/.installed_modules" ]]; then
        echo "on"
        return
    fi


    if grep --quiet "${1}" "${ROOT_DIR}/.installed_modules"; then
        echo "off"
    else
        echo "on"
    fi
}

### BEGIN System checker
CONFIGURATOR_VERSION="20.04"
UBUNTU_VERSION=$(lsb_release --release --short)

if [[ "${UBUNTU_VERSION}" != "${CONFIGURATOR_VERSION}" ]]; then
    echo -e "\e[31mERROR: This configurator is only for Ubuntu ${CONFIGURATOR_VERSION}\e[39m"
    exit 1
fi
### END System checker
