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
    sudo -i -H -u "${USER_NAME}" "${@}"
}

text_input() {
    zenity --entry --title="Ubuntu Configurator" --text="${1}"
}

password_input() {
    zenity --password --title="Ubuntu Configurator" --text="${1}"
}

function is_installed() {
    if [[ ! -f "${ROOT_DIR}/.installed_modules" ]]; then
        echo "on"
        return
    fi

    grep --quiet "${1}" "${ROOT_DIR}/.installed_modules"
    if [[ "${?}" == "0" || "${INSTALATION_PROFILE}" == "custom-zero" ]]; then
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

INSTALATION_PROFILE=$(whiptail --radiolist "Select which services do you want to install. " \
    10 94 4 \
    "update" "Update system packages" on \
    "mini" "Minimal installation" off \
    "custom" "Choose your favourite packages (not installed modules are selected)" off \
    "custom-zero" "Choose your favourite packages" off \
    3>&2 2>&1 1>&3)

if [[ "${INSTALATION_PROFILE}" == "update" ]]; then
    CHOICES="self-update update"

    if which docker-compose > /dev/null; then
        CHOICES="${CHOICES} docker-compose"
    fi

    if [[ -f "${ROOT_DIR}/bin/PrusaSlicer.AppImage" ]]; then
        CHOICES="${CHOICES} prusa-slicer"
    fi

    date '+%Y-%m-%d %H:%M:%S' > "${ROOT_DIR}/.last_update"
fi

if [[ "${INSTALATION_PROFILE}" == "mini" ]]; then
    CHOICES="update brave thunderbird git sublime-text-3 ufw"
fi

if [[ "${INSTALATION_PROFILE}" == "custom" || "${INSTALATION_PROFILE}" == "custom-zero" ]]; then
    CHOICES=$(whiptail --checklist "Select which services do you want to install. " \
        20 83 15 \
        "7zip" "7zip" $(is_installed "7zip") \
        "blender" "Blender" $(is_installed "blender") \
        "brave" "Brave Browser" $(is_installed "brave") \
        "chrome" "chrome" $(is_installed "chrome") \
        "composer" "composer" $(is_installed "composer") \
        "composer-test-utils" "composer test utils" $(is_installed "composer-test-utils") \
        "cpufreq" "cpufreq" $(is_installed "cpufreq") \
        "diagnostic-tools" "diagnostic tools" $(is_installed "diagnostic-tools") \
        "diff-utils" "diff utils" $(is_installed "diff-utils") \
        "docker" "docker" $(is_installed "docker") \
        "docker-compose" "docker compose" $(is_installed "docker-compose") \
        "fiezilla" "fiezilla" $(is_installed "fiezilla") \
        "firefox" "firefox" $(is_installed "firefox") \
        "ftpfs" "ftpfs" $(is_installed "ftpfs") \
        "gimp" "gimp" $(is_installed "gimp") \
        "git" "git" $(is_installed "git") \
        "git-config" "git config" $(is_installed "git-config") \
        "git-hooks" "git hooks" $(is_installed "git-hooks") \
        "gnome" "Gnome tools" $(is_installed "gnome") \
        "gparted" "gparted" $(is_installed "gparted") \
        "gpg" "gpg" $(is_installed "gpg") \
        "gpg-create-key" "gpg create key" $(is_installed "gpg-create-key") \
        "insomnia" "insomnia" $(is_installed "insomnia") \
        "jetbrains-toolbox" "jetbrains toolbox" $(is_installed "jetbrains-toolbox") \
        "kvm-for-android-studio" "kvm for android studio" $(is_installed "kvm-for-android-studio") \
        "libreoffice" "libreoffice" $(is_installed "libreoffice") \
        "mysql" "mysql" $(is_installed "mysql") \
        "nautilus-extensions" "nautilus extensions" $(is_installed "nautilus-extensions") \
        "network-tools" "network tools" $(is_installed "network-tools") \
        "nfs" "nfs" $(is_installed "nfs") \
        "nodejs-12" "nodejs 12" $(is_installed "nodejs-12") \
        "obs-studio" "OBS Studio" $(is_installed "obs-studio") \
        "openvpn-client" "openvpn client" $(is_installed "openvpn-client") \
        "php7.4-with-extensions" "PHP 7.4 with extensions" $(is_installed "php7.4-with-extensions") \
        "php8.0-with-extensions" "PHP 8.0 with extensions" $(is_installed "php8.0-with-extensions") \
        "postgresql" "postgresql" $(is_installed "postgresql") \
        "postman" "postman" $(is_installed "postman") \
        "prusa-slicer" "Prusa Slicer" $(is_installed "prusa-slicer") \
        "rkhunter" "rkhunter" $(is_installed "rkhunter") \
        "rsync" "rsync" $(is_installed "rsync") \
        "secure-delete" "secure delete" $(is_installed "secure-delete") \
        "shellcheck" "shellcheck" $(is_installed "shellcheck") \
        "signal" "Signal" $(is_installed "signal") \
        "slack" "slack" $(is_installed "slack") \
        "smart-tools" "smart tools" $(is_installed "smart-tools") \
        "speedtest" "speedtest" $(is_installed "speedtest") \
        "spotify" "spotify" $(is_installed "spotify") \
        "ssh-keygen" "ssh keygen" $(is_installed "ssh-keygen") \
        "ssh-server" "ssh server" $(is_installed "ssh-server") \
        "sshfs" "sshfs" $(is_installed "sshfs") \
        "sublime-text-3" "sublime text 3" $(is_installed "sublime-text-3") \
        "symfony-cli" "symfony cli" $(is_installed "symfony-cli") \
        "thunderbird" "thunderbird" $(is_installed "thunderbird") \
        "tmux" "tmux" $(is_installed "tmux") \
        "ufw" "ufw" $(is_installed "ufw") \
        "virtualbox" "virtualbox" $(is_installed "virtualbox") \
        "vlc" "vlc" $(is_installed "vlc") \
        "webp" "webp" $(is_installed "webp") \
        "yarn" "yarn" $(is_installed "yarn") \
        "zsh" "zsh" $(is_installed "zsh") \
        "zsh-fzf" "zsh fzf" $(is_installed "zsh-fzf") \
        "zsh-oh-my-zsh" "Oh my ZSH" $(is_installed "zsh-oh-my-zsh") \
        "jakub-customs" "Jacob's specific modifications of the system" off \
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

echo "${CHOICES}" >> "${ROOT_DIR}/.installed_modules"

for CHOICE in ${CHOICES}; do
    CHOICE=$(echo "${CHOICE}" | tr --delete '"')
    # shellcheck disable=SC1090
    echo -e "\e[33m======================================== BEGIN: ${CHOICE} ========================================\e[39m"
    source "${MODULES_DIR}/${CHOICE}.sh"
    echo -e "\e[33m======================================== END: ${CHOICE} ========================================\e[39m"
done

if ${SHOULD_REBOOT}; then
    if zenity --question --text="Do you want to reboot your system?"; then
        reboot
    fi
fi
