#!/usr/bin/env bash

set -o errexit
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
  "update-system" "Update system" on \
  "system-tools" "System tools" on \
  "git" "with custom hooks and configs" on \
  "ssh-keygen" "Generate SSH Key" on \
  "diagnostic-tools" "Diagnostic tools" on \
  "database-clients" "Native database clients" on \
  "dev-tools-common" "Tools for all developers" on \
  "dev-tools-php" "Tools for PHP developers" on \
  "dev-tools-frontend" "Tools for frontend developers" on \
  "terminal" "Eg. Z Shell and other modifications" on \
  "browsers" "Eg. Chrome, Firefox" on \
  "ide-editors" "Sublime Text 3, Jetbrains Toolbox" on \
  "communication" "Eg. Slack" on \
  "office" "Eg. LibreOffice, GIMP" on \
  "graphics" "Graphics programs" on \
  "disk" "Disk tools" on \
  "security" "Eg. Firewall" on \
  "media" "Eg. Spotify, VLC" on \
  "ssh-server" "With secure configuration" on \
  "documentation" "Generators, converters etc" on \
  "jakubs-custom" "Jakub's customization" on \
  "virtualbox" "If you want to install other systems ;)" on \
  "android-tuning" "Tuning for Android's virtual machine" on \
  3>&2 2>&1 1>&3)

#  "docker" "With docker-compose" off \ ### TODO: when it will be available

# shellcheck disable=SC1090
source "${MODULES_DIR}"/required.sh

for CHOICE in ${CHOICES}; do
  CHOICE=$(echo "${CHOICE}" | tr --delete '"')
  # shellcheck disable=SC1090
  source "${MODULES_DIR}/${CHOICE}.sh"
done

#if zenity --question --text="Do you want to reboot your system?"; then
#  reboot
#fi
