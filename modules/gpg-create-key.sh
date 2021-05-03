#!/usr/bin/env bash

if ! which gpg > /dev/null; then
	source "${MODULES_DIR}/gpg.sh"
fi

KEYGEN_CONFIG_FILE="${ROOT_DIR}/keygen_config"

while [[ -z ${REAL_NAME} ]]; do
    REAL_NAME=$(text_input "Your Real Name")
done

while [[ -z ${EMAIL} ]]; do
    EMAIL=$(text_input "Your Email")
done

while [[ -z ${GPG_PASSPHRASE} ]]; do
    GPG_PASSPHRASE=$(password_input "Your Passphrase for GPG Key")
done

echo "Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Name-Real: ${REAL_NAME}
Name-Email: ${EMAIL}
Expire-Date: 0
Passphrase: ${GPG_PASSPHRASE}
" > "${KEYGEN_CONFIG_FILE}"

run_as_user gpg --gen-key --batch "${KEYGEN_CONFIG_FILE}"

shred --remove --iterations=100 "${KEYGEN_CONFIG_FILE}"

GPG_ID=$(gpg --list-secret-keys --with-colons 2>/dev/null | grep '^sec:' | cut --delimiter ':' --fields 5)
if [[ -n "${GPG_ID}" ]]; then
    sed --in-place --regexp-extended "s/.*export GPGKEY.*\n//g" "${USER_HOME}/.bashrc" "${USER_HOME}/.zshrc"

    echo "export GPGKEY=${GPG_ID}" | run_as_user tee --append "${USER_HOME}/.bashrc" | run_as_user tee --append "${USER_HOME}/.zshrc"

    if which git > /dev/null; then
        run_as_user git config --global user.signingkey "${GPG_ID}"
        run_as_user git config --global commit.gpgsign true
    fi
fi
