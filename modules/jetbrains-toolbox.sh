#!/usr/bin/env bash

if [[ ! -f ~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox ]]; then
    RELEASE_JSON=$(curl --silent "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release")
    LATEST_URL=$(printf %s "${RELEASE_JSON}" | jq '.TBA[0].downloads.linux.link' | tr --delete '"')
    LATEST_BUILD=$(printf %s "${RELEASE_JSON}" | jq '.TBA[0].build' | tr --delete '"')
    TOOLBOX_FILE="${ROOT_DIR}/toolbox.tgz"

    wget --output-document="${TOOLBOX_FILE}" "${LATEST_URL}"
    tar --extract --gzip --file="${TOOLBOX_FILE}"

    jetbrains-toolbox-"${LATEST_BUILD}"/jetbrains-toolbox

    rm "${TOOLBOX_FILE}"
    rm --recursive --force jetbrains-toolbox-"${LATEST_BUILD}"
fi

grep 'max_user_watches' /etc/sysctl.conf
if [[ "${?}" == "1" ]]; then
    echo "fs.inotify.max_user_watches = 524288" | sudo tee --append /etc/sysctl.conf
    sudo sysctl --load --system
fi
