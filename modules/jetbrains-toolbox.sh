#!/usr/bin/env bash

SYSCTL_FILE="/etc/sysctl.conf"
MAX_USER_WATCHES="fs.inotify.max_user_watches = 524288"

if [[ ! -f "${USER_HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox" ]]; then
    RELEASE_JSON=$(curl --silent "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release")
    LATEST_URL=$(printf %s "${RELEASE_JSON}" | jq '.TBA[0].downloads.linux.link' | tr --delete '"')
    LATEST_BUILD=$(printf %s "${RELEASE_JSON}" | jq '.TBA[0].build' | tr --delete '"')
    TOOLBOX_FILE="${ROOT_DIR}/toolbox.tgz"

    wget --output-document="${TOOLBOX_FILE}" "${LATEST_URL}"
    run_as_user tar --extract --gzip --file="${TOOLBOX_FILE}"

    run_as_user jetbrains-toolbox-"${LATEST_BUILD}"/jetbrains-toolbox

    rm "${TOOLBOX_FILE}"
    rm --recursive --force jetbrains-toolbox-"${LATEST_BUILD}"
fi

if ! grep 'max_user_watches' "${SYSCTL_FILE}"; then
    echo "${MAX_USER_WATCHES}" >> "${SYSCTL_FILE}"
else
    sed --in-place --regexp-extended "s/.*fs.inotify.max_user_watches.*/${MAX_USER_WATCHES}/g" "${SYSCTL_FILE}"
fi
sysctl --load --system
