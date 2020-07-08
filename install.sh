#!/usr/bin/env bash

set -o pipefail
set -o xtrace

# shellcheck disable=SC2034
CONFIGURATOR_VERSION="20.04"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${ROOT_DIR}/modules"

text_input() {
  zenity --entry --title="Ubuntu Configurator" --text="${1}"
}

password_input() {
  zenity --password --title="Ubuntu Configurator" --text="${1}"
}

# shellcheck disable=SC1090
source "${MODULES_DIR}"/check.sh

sudo echo -e "\e[32mLet's start the installation ;)\e[39m"

CHOICES=$(whiptail --checklist "Select which services do you want to install. " \
  30 77 22 \
  "system-tools" "System tools" off \
  "git" "with custom hooks and configs" off \
  "ssh-keygen" "Generate SSH Key" off \
  "diagnostic-tools" "Diagnostic tools" off \
  "database-clients" "Native database clients" off \
  "dev-tools-common" "Tools for all developers" off \
  "dev-tools-php" "Tools for PHP developers" off \
  "dev-tools-frontend" "Tools for frontend developers" off \
  "terminal" "Eg. Z Shell and other modifications" off \
  "browsers" "Eg. Chrome, Firefox" off \
  "ide-editors" "Sublime Text 3, Jetbrains Toolbox" off \
  "communication" "Eg. Slack" off \
  "office" "Eg. LibreOffice, GIMP" off \
  "graphics" "Graphics programs" off \
  "disk" "Disk tools" off \
  "security" "Eg. Firewall" off \
  "media" "Eg. Spotify, VLC" off \
  "ssh-server" "With secure configuration" off \
  "jakubs-custom" "Jakub's customization" off \
  "virtualbox" "If you want to install other systems ;)" off \
  "android-tuning" "Tuning for Android's virtual machine" off \
  3>&2 2>&1 1>&3)

#  "docker" "With docker-compose" off \ ### TODO: when it will be available

if [[ "${CHOICES}" == "" ]]; then
  exit 0
fi

# shellcheck disable=SC1090
source "${MODULES_DIR}"/required.sh

for CHOICE in ${CHOICES}; do
  CHOICE=$(echo "${CHOICE}" | tr --delete '"')
  # shellcheck disable=SC1090
  source "${MODULES_DIR}/${CHOICE}.sh"
done

if zenity --question --text="Do you want to reboot your system?"; then
  reboot
fi
