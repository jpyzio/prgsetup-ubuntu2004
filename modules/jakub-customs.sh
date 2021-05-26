#!/usr/bin/env bash

cat "${ROOT_DIR}/assets/dconf-settings.ini" | sed 's|ROOT_DIR|'${ROOT_DIR}'|g' | run_as_user dconf load /

# ====================================================================================================================================

for GROUP in video kvm www-data plugdev sambashare lpadmin adm sudo dialout; do
    if ! groups | grep --quiet "${GROUP}"; then # The user does not belong to the group
        if cut -d: -f1 /etc/group | tr '\n' ' ' | grep --quiet "${GROUP}"; then # The group exists
            usermod --append --groups "${USER_NAME}" "${USER_NAME}"
        fi
    fi
done

# ====================================================================================================================================

run_as_user gsettings set org.gnome.desktop.interface clock-show-seconds true
run_as_user gsettings set org.gnome.desktop.interface clock-show-weekday true
run_as_user gsettings set org.gnome.desktop.interface show-battery-percentage true

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
