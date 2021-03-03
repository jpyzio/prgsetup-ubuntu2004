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
    "0_system-update" "system update" on \
    "1_kvm-for-android-studio" "kvm for android studio" on \
    "2_slack" "slack" on \
    "3_thunderbird" "thunderbird" on \
    "4_mysql" "mysql" on \
    "5_postgresql" "postgresql" on \
    "6_fiezilla" "fiezilla" on \
    "7_rsync" "rsync" on \
    "8_7zip" "7zip" on \
    "9_diff-utils" "diff utils" on \
    "10_insomnia" "insomnia" on \
    "11_postman" "postman" on \
    "12_nodejs-12" "nodejs 12" on \
    "13_yarn" "yarn" on \
    "14_php7.4-with-extensions" "php7.4 with extensions" on \
    "15_composer" "composer" on \
    "16_composer-test-utils" "composer test utils" on \
    "17_symfony-cli" "symfony cli" on \
    "18_diagnostic-tools" "diagnostic tools" on \
    "19_network-tools" "network tools" on \
    "20_gparted" "gparted" on \
    "21_smart-tools" "smart tools" on \
    "22_secure-delete" "secure delete" on \
    "23_docker" "docker" on \
    "24_docker-compose" "docker compose" on \
    "25_git" "git" on \
    "26_git-hooks" "git hooks" on \
    "27_git-config" "git config" on \
    "28_gpg" "gpg" on \
    "29_gpg-create-key" "gpg create key" on \
    "30_gimp" "gimp" on \
    "31_webp" "webp" on \
    "32_nautilus-extensions" "nautilus extensions" on \
    "33_sublime-text-3" "sublime text 3" on \
    "34_jetbrains-toolbox" "jetbrains toolbox" on \
    "35_jakoob-system-dock" "jakoob system dock" on \
    "36_jakoob-aliases" "jakoob aliases" on \
    "37_shellcheck" "shellcheck" on \
    "38_speedtest" "speedtest" on \
    "39_cpufreq" "cpufreq" on \
    "40_cpufreq-set-performance" "cpufreq set performance" on \
    "41_jakub-user-groups" "jakub user groups" on \
    "42_vlc" "vlc" on \
    "43_spotify" "spotify" on \
    "44_libreonice" "libreonice" on \
    "45_ufw" "ufw" on \
    "46_rkhunter" "rkhunter" on \
    "47_ssh-keygen" "ssh keygen" on \
    "48_ssh-server" "ssh server" on \
    "49_sshfs" "sshfs" on \
    "50_nfs" "nfs" on \
    "51_ftpfs" "ftpfs" on \
    "52_openvpn-client" "openvpn client" on \
    "53_zsh" "zsh" on \
    "54_tmux" "tmux" on \
    "55_oh-my-zsh" "oh my zsh" on \
    "56_zsh-fzf" "zsh fzf" on \
    "57_jakoob-zsh-tuning" "jakoob zsh tuning" on \
    "58_virtualbox" "virtualbox" on \
    "59_chrome" "chrome" on \
    "60_firefox" "firefox" on \
    "61_obs-studio" "OBS Studio" on \
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
