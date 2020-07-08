#!/usr/bin/env bash

### BEGIN Dock
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

### END Dock

### BEGIN Custom aliases and functions
for FILE in ~/.bashrc ~/.zshrc; do
  grep -E "source.*custom-functions.sh" "${FILE}" --quiet
  if [[ "${?}" == "1" ]]; then
    echo "source \"${ROOT_DIR}/custom-functions.sh\"" | tee --append "${FILE}"
  fi
done
### END Custom aliases and functions

### BEGIN Packages
sudo apt install --yes shellcheck speedtest-cli
### END Packages

### BEGIN Enable performance mode
sudo apt install --yes cpufrequtils

grep 'GOVERNOR="performance"' /etc/default/cpufrequtils --quiet
if [[ "${?}" == "1" ]]; then
  echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
fi

sudo systemctl disable ondemand
### END Enable performance mode
