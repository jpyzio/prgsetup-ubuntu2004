#!/usr/bin/env bash

gsettings set org.gnome.desktop.background picture-uri file:///$(realpath ../assets/wallpaper.jpg)

for GROUP in video kvm www-data plugdev sambashare lpadmin adm sudo dialout; do
    if ! groups | grep --quiet "${GROUP}"; then # The user does not belong to the group
        if cut -d: -f1 /etc/group | tr '\n' ' ' | grep --quiet "${GROUP}"; then # The group exists
            usermod --append --groups "${USER_NAME}" "${USER_NAME}"
        fi
    fi
done

if [[ -f "${USER_HOME}/.zshrc" ]]; then
    if ! grep --quiet 'forward-word' "${USER_HOME}/.zshrc"; then
        echo -e "bindkey \"^[[1;3C\" forward-word\nbindkey \"^[[1;3D\" backward-word" | tee --append "${USER_HOME}/.zshrc"
    fi
fi

gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 50
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true

gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface show-battery-percentage true

#gsettings set org.gnome.desktop.peripherials.keyboard numlock-state true
#gsettings set org.gnome.desktop.peripherials.keyboard remember-numlock-state true
#gsettings set org.gnome.desktop.peripherials.touchpad disable-while-typing true

for FILE in ${USER_HOME}/.bashrc ${USER_HOME}/.zshrc; do
    if ! grep --quiet -E "source.*aliases.sh" "${FILE}"; then
        echo "source \"${ROOT_DIR}/aliases.sh\"" >> "${FILE}"
        chown "${USER_NAME}". "${FILE}"
    fi
done