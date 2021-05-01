#!/usr/bin/env bash

if ! which google-chrome > /dev/null; then
    CHROME_FILE="${ROOT_DIR}/google-chrome.deb"
    CHROME_DEB_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

    wget --output-document="${CHROME_FILE}" "${CHROME_DEB_URL}"
    gdebi --non-interactive "${CHROME_FILE}"
    rm "${CHROME_FILE}"
fi

apt install --yes chrome-gnome-shell
