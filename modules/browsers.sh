#!/usr/bin/env bash

### BEGIN Google Chrome
which google-chrome > /dev/null
if [[ "${?}" == "1" ]]; then
  CHROME_FILE="${ROOT_DIR}/google-chrome.deb"

  wget --output-document="${CHROME_FILE}" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo gdebi --non-interactive "${CHROME_FILE}"
  rm "${CHROME_FILE}"
fi
### END Google Chrome

### BEGIN Firefox
sudo apt install --yes firefox firefox-locale-en firefox-locale-pl
### END Firefox
