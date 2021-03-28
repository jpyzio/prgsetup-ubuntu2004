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

### BEGIN System checker
UBUNTU_VERSION=$(lsb_release --release --short)

if [[ "${UBUNTU_VERSION}" != "${CONFIGURATOR_VERSION}" ]]; then
    echo -e "\e[31mERROR: This configurator is only for Ubuntu ${CONFIGURATOR_VERSION}\e[39m"
    exit 1
fi
### END System checker

sudo echo -e "\e[32mLet's start the installation ;)\e[39m"

CHOICES=$(whiptail --checklist "Select which services do you want to install. " \
    30 77 22 \
    "system-update" "system update" on \
    "kvm-for-android-studio" "kvm for android studio" on \
    "slack" "slack" on \
    "thunderbird" "thunderbird" on \
    "mysql" "mysql" on \
    "postgresql" "postgresql" on \
    "fiezilla" "fiezilla" on \
    "rsync" "rsync" on \
    "7zip" "7zip" on \
    "diff-utils" "diff utils" on \
    "insomnia" "insomnia" on \
    "postman" "postman" on \
    "nodejs-12" "nodejs 12" on \
    "yarn" "yarn" on \
    "php7.4-with-extensions" "php7.4 with extensions" on \
    "composer" "composer" on \
    "composer-test-utils" "composer test utils" on \
    "symfony-cli" "symfony cli" on \
    "diagnostic-tools" "diagnostic tools" on \
    "network-tools" "network tools" on \
    "gparted" "gparted" on \
    "smart-tools" "smart tools" on \
    "secure-delete" "secure delete" on \
    "docker" "docker" on \
    "docker-compose" "docker compose" on \
    "git" "git" on \
    "git-hooks" "git hooks" on \
    "git-config" "git config" on \
    "gpg" "gpg" on \
    "gpg-create-key" "gpg create key" on \
    "gimp" "gimp" on \
    "webp" "webp" on \
    "nautilus-extensions" "nautilus extensions" on \
    "sublime-text-3" "sublime text 3" on \
    "jetbrains-toolbox" "jetbrains toolbox" on \
    "jakoob-system-dock" "jakoob system dock" on \
    "jakoob-aliases" "jakoob aliases" on \
    "shellcheck" "shellcheck" on \
    "speedtest" "speedtest" on \
    "cpufreq" "cpufreq" on \
    "cpufreq-set-performance" "cpufreq set performance" on \
    "jakub-user-groups" "jakub user groups" on \
    "vlc" "vlc" on \
    "spotify" "spotify" on \
    "libreonice" "libreonice" on \
    "ufw" "ufw" on \
    "rkhunter" "rkhunter" on \
    "ssh-keygen" "ssh keygen" on \
    "ssh-server" "ssh server" on \
    "sshfs" "sshfs" on \
    "nfs" "nfs" on \
    "ftpfs" "ftpfs" on \
    "openvpn-client" "openvpn client" on \
    "zsh" "zsh" on \
    "tmux" "tmux" on \
    "oh-my-zsh" "oh my zsh" on \
    "zsh-fzf" "zsh fzf" on \
    "jakoob-zsh-tuning" "jakoob zsh tuning" on \
    "virtualbox" "virtualbox" on \
    "chrome" "chrome" on \
    "firefox" "firefox" on \
    "obs-studio" "OBS Studio" on \
    3>&2 2>&1 1>&3)

if [[ "${CHOICES}" == "" ]]; then
    exit 0
fi

sudo apt update

if [[ ! -f "${ROOT_DIR}/.installed" ]] ; then
    # shellcheck disable=SC1090
    source "${MODULES_DIR}/0_system-update.sh"
    touch "${ROOT_DIR}/.installed"
fi

for CHOICE in ${CHOICES}; do
    CHOICE=$(echo "${CHOICE}" | tr --delete '"')
    # shellcheck disable=SC1090
    source "${MODULES_DIR}/${CHOICE}.sh"
done

sudo apt autoremove --yes
sudo apt autoclean --yes

if zenity --question --text="Do you want to reboot your system?"; then
    reboot
fi
