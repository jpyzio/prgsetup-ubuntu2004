#!/usr/bin/env bash

if [[ "$(id -u)" -eq 0 ]]; then
    echo -e "\e[31mThis script must be run as normal user!\e[39m"
    exit 1
fi

set -o pipefail
set -o xtrace

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

# ====================================================================================================================================

sudo apt install --yes dconf-editor

for CONF in "key-bindings"; do
    sed 's|ROOT_DIR|'"${ROOT_DIR}"'|g' "${ROOT_DIR}/assets/dconf/${CONF}.ini" | dconf load /
done

# ====================================================================================================================================

for GROUP in video kvm www-data plugdev sambashare lpadmin adm sudo dialout; do
    if ! groups | grep --quiet "${GROUP}"; then # The user does not belong to the group
        if cut -d: -f1 /etc/group | tr '\n' ' ' | grep --quiet "${GROUP}"; then # The group exists
            sudo usermod --append --groups "${GROUP}" "${USER_NAME}"
        fi
    fi
done

# ====================================================================================================================================

if [[ -f "${USER_HOME}/.zshrc" ]]; then
    if ! grep --quiet 'forward-word' "${USER_HOME}/.zshrc"; then
        echo -e "bindkey \"^[[1;3C\" forward-word\nbindkey \"^[[1;3D\" backward-word" >> "${USER_HOME}/.zshrc"
    fi
fi

for FILE in ${USER_HOME}/.bashrc ${USER_HOME}/.zshrc; do
    if ! grep --quiet -E "source.*aliases.sh" "${FILE}"; then
        echo "source \"${ROOT_DIR}/assets/aliases.sh\"" >> "${FILE}"
    fi
    if ! grep --quiet -E "source.*functions.sh" "${FILE}"; then
        echo "source \"${ROOT_DIR}/assets/functions.sh\"" >> "${FILE}"
    fi
    chown "${USER_NAME}". "${FILE}"
done

# ====================================================================================================================================

if which google-chrome > /dev/null; then
    sudo apt install --yes chrome-gnome-shell

    google-chrome https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep/

    google-chrome https://extensions.gnome.org/extension/1271/sound-settings/ \
        https://extensions.gnome.org/extension/7/removable-drive-menu/ \
        https://extensions.gnome.org/extension/750/openweather/ \
        https://extensions.gnome.org/extension/104/netspeed/ \
        https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/ \
        https://extensions.gnome.org/extension/945/cpu-power-manager/ \
        https://extensions.gnome.org/extension/779/clipboard-indicator/
fi

# ====================================================================================================================================

if which brave-browser > /dev/null; then
    brave-browser https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd
fi

# ====================================================================================================================================

rm -f "${USER_HOME}/.face"
ln -s "${ROOT_DIR}/assets/face" "${USER_HOME}/.face"
