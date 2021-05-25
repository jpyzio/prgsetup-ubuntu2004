#!/usr/bin/env bash

BIN_DIR="${USER_HOME}/bin"

FILE_URL=$(curl -s https://api.github.com/repos/prusa3d/PrusaSlicer/releases/latest | grep AppImage | grep browser_download_url | grep -E 'https\:\/\/.*\-x64\-20' | xargs | cut -d ' ' -f2)

mkdir -p "${BIN_DIR}"

curl --location "${FILE_URL}" --output "${BIN_DIR}/PrusaSlicer.AppImage"
chmod +x "${BIN_DIR}/PrusaSlicer.AppImage"

chown -R "${USER_NAME}". "${BIN_DIR}"
