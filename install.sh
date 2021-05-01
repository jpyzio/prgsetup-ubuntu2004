#!/usr/bin/env bash

if [[ "$(id -u)" -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

set -o pipefail
set -o xtrace

# shellcheck disable=SC2034
CONFIGURATOR_VERSION="20.04"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${ROOT_DIR}/modules"

run_as_user() {
    sudo -i -u "$(logname)" "${@}"
}

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

INSTALATION_PROFILE=$(whiptail --radiolist "Select which services do you want to install. " \
    15 52 5 \
    "update" "Update system packages" on \
    "mini" "Minimal installation" off \
    "full" "All packages" off \
    "custom" "Choose your favourite packages" off \
    3>&2 2>&1 1>&3)

if [[ "${INSTALATION_PROFILE}" == "update" ]]; then
    CHOICES="self-update update docker-compose"
fi

if [[ "${INSTALATION_PROFILE}" == "mini" ]]; then
    CHOICES="update autoupdate zsh chrome thunderbird git sublime-text-3 ufw"
fi

if [[ "${INSTALATION_PROFILE}" == "full" ]]; then
    CHOICES="brave kvm-for-android-studio slack thunderbird mysql postgresql fiezilla rsync 7zip diff-utils insomnia postman nodejs-12 yarn php7.4-with-extensions" \
        " composer composer-test-utils symfony-cli diagnostic-tools network-tools gparted smart-tools secure-delete docker docker-compose git git-hooks git-config gpg gpg-create-key" \
        " gimp webp nautilus-extensions sublime-text-3 jetbrains-toolbox jakoob-system-dock jakoob-aliases shellcheck speedtest cpufreq cpufreq-set-performance jakub-user-groups vlc" \
        " spotify libreoffice ufw rkhunter ssh-keygen ssh-server sshfs nfs ftpfs openvpn-client zsh tmux oh-my-zsh zsh-fzf jakoob-zsh-tuning virtualbox chrome firefox obs-studio signal"
fi

if [[ "${INSTALATION_PROFILE}" == "custom" ]]; then
    CHOICES=$(whiptail --checklist "Select which services do you want to install. " \
        30 77 22 \
        "7zip" "7zip" off \
        "brave" "Brave Browser" off \
        "chrome" "chrome" off \
        "composer-test-utils" "composer test utils" off \
        "composer" "composer" off \
        "cpufreq-set-performance" "cpufreq set performance" off \
        "cpufreq" "cpufreq" off \
        "diagnostic-tools" "diagnostic tools" off \
        "diff-utils" "diff utils" off \
        "docker-compose" "docker compose" off \
        "docker" "docker" off \
        "fiezilla" "fiezilla" off \
        "firefox" "firefox" off \
        "ftpfs" "ftpfs" off \
        "gimp" "gimp" off \
        "git-config" "git config" off \
        "git-hooks" "git hooks" off \
        "git" "git" off \
        "gparted" "gparted" off \
        "gpg-create-key" "gpg create key" off \
        "gpg" "gpg" off \
        "insomnia" "insomnia" off \
        "jakoob-aliases" "jakoob aliases" off \
        "jakoob-system-dock" "jakoob system dock" off \
        "jakoob-zsh-tuning" "jakoob zsh tuning" off \
        "jakub-user-groups" "jakub user groups" off \
        "jetbrains-toolbox" "jetbrains toolbox" off \
        "kvm-for-android-studio" "kvm for android studio" off \
        "libreoffice" "libreoffice" off \
        "mysql" "mysql" off \
        "nautilus-extensions" "nautilus extensions" off \
        "network-tools" "network tools" off \
        "nfs" "nfs" off \
        "nodejs-12" "nodejs 12" off \
        "obs-studio" "OBS Studio" off \
        "oh-my-zsh" "oh my zsh" off \
        "openvpn-client" "openvpn client" off \
        "php7.4-with-extensions" "PHP 7.4 with extensions" off \
        "php8.0-with-extensions" "PHP 8.0 with extensions" off \
        "postgresql" "postgresql" off \
        "postman" "postman" off \
        "rkhunter" "rkhunter" off \
        "rsync" "rsync" off \
        "secure-delete" "secure delete" off \
        "shellcheck" "shellcheck" off \
        "signal" "Signal" off \
        "slack" "slack" off \
        "smart-tools" "smart tools" off \
        "speedtest" "speedtest" off \
        "spotify" "spotify" off \
        "ssh-keygen" "ssh keygen" off \
        "ssh-server" "ssh server" off \
        "sshfs" "sshfs" off \
        "sublime-text-3" "sublime text 3" off \
        "symfony-cli" "symfony cli" off \
        "thunderbird" "thunderbird" off \
        "tmux" "tmux" off \
        "ufw" "ufw" off \
        "virtualbox" "virtualbox" off \
        "vlc" "vlc" off \
        "webp" "webp" off \
        "yarn" "yarn" off \
        "zsh-fzf" "zsh fzf" off \
        "zsh" "zsh" off \
        3>&2 2>&1 1>&3)
fi

if [[ "${CHOICES}" == "" ]]; then
    echo "No packages selected"
    exit 1
fi

apt update

if [[ ! -f "${ROOT_DIR}/.installed" ]]; then
    # shellcheck disable=SC1090
    source "${MODULES_DIR}/update.sh"
    date '+%Y-%m-%d %H:%M:%S' >"${ROOT_DIR}/.installed"
fi

for CHOICE in ${CHOICES}; do
    CHOICE=$(echo "${CHOICE}" | tr --delete '"')
    # shellcheck disable=SC1090
    source "${MODULES_DIR}/${CHOICE}.sh"
done

if zenity --question --text="Do you want to reboot your system?"; then
    reboot
fi
