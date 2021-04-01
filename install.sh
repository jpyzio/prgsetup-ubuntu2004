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

INSTALATION_PROFILE=$(whiptail --radiolist "Select which services do you want to install. " \
    10 52 5 \
    "full" "All packages" on \
    "mini" "Minimal installation" off \
    "custom" "Choose your favourite packages" off \
    3>&2 2>&1 1>&3)


if [[ "${INSTALATION_PROFILE}" == "full" ]]; then
    CHOICES="system-update autoupdate kvm-for-android-studio slack thunderbird mysql postgresql fiezilla rsync 7zip diff-utils insomnia postman nodejs-12 yarn php7.4-with-extensions" \
    " composer composer-test-utils symfony-cli diagnostic-tools network-tools gparted smart-tools secure-delete docker docker-compose git git-hooks git-config gpg gpg-create-key" \
    " gimp webp nautilus-extensions sublime-text-3 jetbrains-toolbox jakoob-system-dock jakoob-aliases shellcheck speedtest cpufreq cpufreq-set-performance jakub-user-groups vlc" \
    " spotify libreonice ufw rkhunter ssh-keygen ssh-server sshfs nfs ftpfs openvpn-client zsh tmux oh-my-zsh zsh-fzf jakoob-zsh-tuning virtualbox chrome firefox obs-studio"
fi

if [[ "${INSTALATION_PROFILE}" == "mini" ]]; then
    CHOICES="system-update autoupdate zsh chrome thunderbird git sublime-text-3 ufw"
fi

if [[ "${INSTALATION_PROFILE}" == "custom" ]]; then
    CHOICES=$(whiptail --checklist "Select which services do you want to install. " \
        30 77 22 \
        "system-update" "system update" on \
        "autoupdate" "system periodic update" on \
        "kvm-for-android-studio" "kvm for android studio" off \
        "slack" "slack" off \
        "thunderbird" "thunderbird" off \
        "mysql" "mysql" off \
        "postgresql" "postgresql" off \
        "fiezilla" "fiezilla" off \
        "rsync" "rsync" off \
        "7zip" "7zip" off \
        "diff-utils" "diff utils" off \
        "insomnia" "insomnia" off \
        "postman" "postman" off \
        "nodejs-12" "nodejs 12" off \
        "yarn" "yarn" off \
        "php7.4-with-extensions" "php7.4 with extensions" off \
        "composer" "composer" off \
        "composer-test-utils" "composer test utils" off \
        "symfony-cli" "symfony cli" off \
        "diagnostic-tools" "diagnostic tools" off \
        "network-tools" "network tools" off \
        "gparted" "gparted" off \
        "smart-tools" "smart tools" off \
        "secure-delete" "secure delete" off \
        "docker" "docker" off \
        "docker-compose" "docker compose" off \
        "git" "git" off \
        "git-hooks" "git hooks" off \
        "git-config" "git config" off \
        "gpg" "gpg" off \
        "gpg-create-key" "gpg create key" off \
        "gimp" "gimp" off \
        "webp" "webp" off \
        "nautilus-extensions" "nautilus extensions" off \
        "sublime-text-3" "sublime text 3" off \
        "jetbrains-toolbox" "jetbrains toolbox" off \
        "jakoob-system-dock" "jakoob system dock" off \
        "jakoob-aliases" "jakoob aliases" off \
        "shellcheck" "shellcheck" off \
        "speedtest" "speedtest" off \
        "cpufreq" "cpufreq" off \
        "cpufreq-set-performance" "cpufreq set performance" off \
        "jakub-user-groups" "jakub user groups" off \
        "vlc" "vlc" off \
        "spotify" "spotify" off \
        "libreonice" "libreonice" off \
        "ufw" "ufw" off \
        "rkhunter" "rkhunter" off \
        "ssh-keygen" "ssh keygen" off \
        "ssh-server" "ssh server" off \
        "sshfs" "sshfs" off \
        "nfs" "nfs" off \
        "ftpfs" "ftpfs" off \
        "openvpn-client" "openvpn client" off \
        "zsh" "zsh" off \
        "tmux" "tmux" off \
        "oh-my-zsh" "oh my zsh" off \
        "zsh-fzf" "zsh fzf" off \
        "jakoob-zsh-tuning" "jakoob zsh tuning" off \
        "virtualbox" "virtualbox" off \
        "chrome" "chrome" off \
        "firefox" "firefox" off \
        "obs-studio" "OBS Studio" off \
    3>&2 2>&1 1>&3)
fi

if [[ "${CHOICES}" == "" ]]; then
    echo "No packages selected"
    exit 1
fi

sudo apt update

if [[ ! -f "${ROOT_DIR}/.installed" ]] ; then
    # shellcheck disable=SC1090
    source "${MODULES_DIR}/system-update.sh"
    echo $(date '+%Y-%m-%d %H:%M:%S') > "${ROOT_DIR}/.installed"
fi

for CHOICE in ${CHOICES}; do
    CHOICE=$(echo "${CHOICE}" | tr --delete '"')
    # shellcheck disable=SC1090
    source "${MODULES_DIR}/${CHOICE}.sh"
done

if zenity --question --text="Do you want to reboot your system?"; then
    reboot
fi
