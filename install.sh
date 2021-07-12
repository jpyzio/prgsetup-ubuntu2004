#!/usr/bin/env bash

set -o pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

while ! echo "${UPDATE_PERIOD}" | grep -qE '^[0-9]+$'; do
    UPDATE_PERIOD=$(text_input "Set update check period [in days]")
done

echo -e "\nUPDATE_PERIOD=${UPDATE_PERIOD}\n${ROOT_DIR}/check.sh" | tee --append ~/.zshrc | tee --append ~/.bashrc
