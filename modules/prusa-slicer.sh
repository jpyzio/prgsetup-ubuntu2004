#!/usr/bin/env bash

BIN_DIR="${USER_HOME}/bin"
FILE_URL="https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.3.1/PrusaSlicer-2.3.1+linux-x64-202104161339.AppImage"

mkdir -p "${BIN_DIR}"

curl --location "${FILE_URL}" --output "${BIN_DIR}/PrusaSlicer.AppImage"
chmod +x "${BIN_DIR}/PrusaSlicer.AppImage"

chown -R "${USER_NAME}". "${BIN_DIR}"
