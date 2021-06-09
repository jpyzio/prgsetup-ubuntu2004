#!/usr/bin/env bash

if ! zoom obs > /dev/null; then
    ZOOM_FILE="${ROOT_DIR}/zoom.deb"
    wget --output-document="${ZOOM_FILE}" https://zoom.us/client/latest/zoom_amd64.deb
    gdebi --non-interactive "${ZOOM_FILE}"
    rm "${ZOOM_FILE}"
fi
