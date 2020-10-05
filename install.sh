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
    "1_kvm-for-android-studio.sh" "kvm for android studio" off \
    "2_slack.sh" "slack" off \
    "3_thunderbird.sh" "thunderbird" off \
    "4_mysql.sh" "mysql" off \
    "5_postgresql.sh" "postgresql" off \
    "6_fiezilla.sh" "fiezilla" off \
    "7_rsync.sh" "rsync" off \
    "8_7zip.sh" "7zip" off \
    "9_diff-utils.sh" "diff utils" off \
    "10_insomnia.sh" "insomnia" off \
    "11_postman.sh" "postman" off \
    "12_nodejs-12.sh" "nodejs 12" off \
    "13_yarn.sh" "yarn" off \
    "14_php7.4-with-extensions.sh" "php7.4 with extensions" off \
    "15_composer.sh" "composer" off \
    "16_composer-test-utils.sh" "composer test utils" off \
    "17_sumfony-cli.sh" "sumfony cli" off \
    "18_diagnostic-tools.sh" "diagnostic tools" off \
    "19_network-tools.sh" "network tools" off \
    "20_gparted.sh" "gparted" off \
    "21_smart-tools.sh" "smart tools" off \
    "22_secure-delete.sh" "secure delete" off \
    "23_docker.sh" "docker" off \
    "24_docker-compose.sh" "docker compose" off \
    "25_git.sh" "git" off \
    "26_git-hooks.sh" "git hooks" off \
    "27_git-config.sh" "git config" off \
    "28_gpg.sh" "gpg" off \
    "29_gpg-create-key.sh" "gpg create key" off \
    "30_gimp.sh" "gimp" off \
    "31_webp.sh" "webp" off \
    "32_nautilus-extensions.sh" "nautilus extensions" off \
    "33_sublime-text-3.sh" "sublime text 3" off \
    "34_jetbrains-toolbox.sh" "jetbrains toolbox" off \
    "35_jakoob-system-dock.sh" "jakoob system dock" off \
    "36_jakoob-aliases.sh" "jakoob aliases" off \
    "37_shellcheck.sh" "shellcheck" off \
    "38_speedtest.sh" "speedtest" off \
    "39_cpufreq.sh" "cpufreq" off \
    "40_cpufreq-set-performance.sh" "cpufreq set performance" off \
    "41_jakub-user-groups.sh" "jakub user groups" off \
    "42_vlc.sh" "vlc" off \
    "43_spotify.sh" "spotify" off \
    "44_libreoffice.sh" "libreoffice" off \
    "45_ufw.sh" "ufw" off \
    "46_rkhunter.sh" "rkhunter" off \
    "47_ssh-keygen.sh" "ssh keygen" off \
    "48_ssh-server.sh" "ssh server" off \
    "49_sshfs.sh" "sshfs" off \
    "50_nfs.sh" "nfs" off \
    "51_ftpfs.sh" "ftpfs" off \
    "52_openvpn-client.sh" "openvpn client" off \
    "53_zsh.sh" "zsh" off \
    "54_tmux.sh" "tmux" off \
    "55_oh-my-zsh.sh" "oh my zsh" off \
    "56_zsh-fzf.sh" "zsh fzf" off \
    "57_jakoob-zsh-tuning.sh" "jakoob zsh tuning" off \
    "58_virtualbox.sh" "virtualbox" off \
    "59_chrome.sh" "chrome" off \
    "60_firefox.sh" "firefox" off \
    "61_obs-studio.sh" "OBS Studio" off \
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
