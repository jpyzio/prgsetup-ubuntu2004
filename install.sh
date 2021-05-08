#!/usr/bin/env bash

if [[ "$(id -u)" -ne 0 ]]; then
    echo -e "\e[31mThis script must be run as root!\e[39m"
    exit 1
fi

set -o pipefail
set -o xtrace

SHOULD_REBOOT=false
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${ROOT_DIR}/modules"
USER_NAME="$(logname)"
USER_HOME="$(eval echo ~"${USER_NAME}")"

run_as_user() {
    sudo -i -u "${USER_NAME}" "${@}"
}

text_input() {
    zenity --entry --title="Ubuntu Configurator" --text="${1}"
}

password_input() {
    zenity --password --title="Ubuntu Configurator" --text="${1}"
}

### BEGIN System checker
CONFIGURATOR_VERSION="20.04"
UBUNTU_VERSION=$(lsb_release --release --short)

if [[ "${UBUNTU_VERSION}" != "${CONFIGURATOR_VERSION}" ]]; then
    echo -e "\e[31mERROR: This configurator is only for Ubuntu ${CONFIGURATOR_VERSION}\e[39m"
    exit 1
fi
### END System checker

INSTALATION_PROFILE=$(whiptail --radiolist "Select which services do you want to install. " \
    10 52 3 \
    "update" "Update system packages" on \
    "mini" "Minimal installation" off \
    "custom" "Choose your favourite packages" off \
    3>&2 2>&1 1>&3)

if [[ "${INSTALATION_PROFILE}" == "update" ]]; then
    CHOICES="self-update update"

    if which docker-compose > /dev/null; then
        CHOICES="${CHOICES} docker-compose"
    fi

    if [[ -f "${USER_HOME}/bin/PrusaSlicer.AppImage" ]]; then
        CHOICES="${CHOICES} prusa-slicer"
    fi

    date '+%Y-%m-%d %H:%M:%S' > "${ROOT_DIR}/.last_update"
fi

if [[ "${INSTALATION_PROFILE}" == "mini" ]]; then
    CHOICES="update brave thunderbird git sublime-text-3 ufw"
fi

if [[ "${INSTALATION_PROFILE}" == "custom" ]]; then
    CHOICES=$(whiptail --checklist "Select which services do you want to install. " \
        20 77 15 \
        "7zip" "7zip" off \
        "brave" "Brave Browser" off \
        "chrome" "chrome" off \
        "composer" "composer" off \
        "composer-test-utils" "composer test utils" off \
        "cpufreq" "cpufreq" off \
        "diagnostic-tools" "diagnostic tools" off \
        "diff-utils" "diff utils" off \
        "docker" "docker" off \
        "docker-compose" "docker compose" off \
        "fiezilla" "fiezilla" off \
        "firefox" "firefox" off \
        "ftpfs" "ftpfs" off \
        "gimp" "gimp" off \
        "git" "git" off \
        "git-config" "git config" off \
        "git-hooks" "git hooks" off \
        "gnome" "Gnome tools" off \
        "gparted" "gparted" off \
        "gpg" "gpg" off \
        "gpg-create-key" "gpg create key" off \
        "insomnia" "insomnia" off \
        "jakoob-aliases" "jakoob aliases" off \
        "jakoob-system-dock" "jakoob system dock" off \
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
        "openvpn-client" "openvpn client" off \
        "php7.4-with-extensions" "PHP 7.4 with extensions" off \
        "php8.0-with-extensions" "PHP 8.0 with extensions" off \
        "postgresql" "postgresql" off \
        "postman" "postman" off \
        "prusa-slicer" "Prusa Slicer" off \
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
        "zsh" "zsh" off \
        "zsh-fzf" "zsh fzf" off \
        "zsh-oh-my-zsh" "Oh my ZSH" off \
        "jakoob-zsh-tuning" "jakoob zsh tuning" off \
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
    date '+%Y-%m-%d %H:%M:%S' > "${ROOT_DIR}/.installed"
fi

for CHOICE in ${CHOICES}; do
    CHOICE=$(echo "${CHOICE}" | tr --delete '"')
    # shellcheck disable=SC1090
    source "${MODULES_DIR}/${CHOICE}.sh"
done

if ${SHOULD_REBOOT}; then
    if zenity --question --text="Do you want to reboot your system?"; then
        reboot
    fi
fi
