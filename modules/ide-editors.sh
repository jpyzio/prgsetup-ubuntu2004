#!/usr/bin/env bash

### END Sublime Text 3
sudo snap install sublime-text --classic
### END Sublime Text 3

### BEGIN Toolbox
RELEASE_JSON=$(curl --silent "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release")
LASTEST_URL=$(printf %s "${RELEASE_JSON}" | jq '.TBA[0].downloads.linux.link' | tr --delete '"')
LASTEST_BUILD=$(printf %s "${RELEASE_JSON}" | jq '.TBA[0].build' | tr --delete '"')
TOOLBOX_FILE="${ROOT_DIR}/toolbox.tgz"

wget --output-document="${TOOLBOX_FILE}" "${LASTEST_URL}"
tar --extract --gzip --file="${TOOLBOX_FILE}"

jetbrains-toolbox-"${LASTEST_BUILD}"/jetbrains-toolbox

rm "${TOOLBOX_FILE}"
rm --recursive --force jetbrains-toolbox-"${LASTEST_BUILD}"
### END Toolbox

### BEGIN Tuning system for Jetbrain's apps
echo "fs.inotify.max_user_watches = 524288" | sudo tee --append /etc/sysctl.conf
sudo sysctl --load --system
### END Tuning system for Jetbrain's apps
