#!/usr/bin/env bash

run_as_user cp "${ROOT_DIR}/assets/face" "${USER_HOME}/.face"

# ====================================================================================================================================

for GROUP in video kvm www-data plugdev sambashare lpadmin adm sudo dialout; do
    if ! groups | grep --quiet "${GROUP}"; then # The user does not belong to the group
        if cut -d: -f1 /etc/group | tr '\n' ' ' | grep --quiet "${GROUP}"; then # The group exists
            usermod --append --groups "${GROUP}" "${USER_NAME}"
        fi
    fi
done

# ====================================================================================================================================

if [[ -f "${USER_HOME}/.zshrc" ]]; then
    if ! grep --quiet 'forward-word' "${USER_HOME}/.zshrc"; then
        echo -e "bindkey \"^[[1;3C\" forward-word\nbindkey \"^[[1;3D\" backward-word" | tee --append "${USER_HOME}/.zshrc"
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

if ! which google-chrome > /dev/null; then
    source "${MODULES_DIR}/google-chrome.sh"
fi

apt install --yes gnome-shell-extensions chrome-gnome-shell

run_as_user google-chrome https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep/

run_as_user google-chrome https://extensions.gnome.org/extension/1271/sound-settings/ \
    https://extensions.gnome.org/extension/7/removable-drive-menu/ \
    https://extensions.gnome.org/extension/750/openweather/ \
    https://extensions.gnome.org/extension/104/netspeed/ \
    https://extensions.gnome.org/extension/1465/desktop-icons/ \
    https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/ \
    https://extensions.gnome.org/extension/945/cpu-power-manager/ \
    https://extensions.gnome.org/extension/779/clipboard-indicator/

# ====================================================================================================================================

if ! which brave-browser > /dev/null; then
    source "${MODULES_DIR}/brave.sh"
fi

run_as_user brave-browser https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd

SHOULD_REBOOT=true
