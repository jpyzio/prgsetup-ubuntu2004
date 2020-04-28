#!/usr/bin/env bash

### BEGIN Generate SSH key
SSH_DIR="${HOME}/.ssh"
PRIVATE_KEY_FILE="${SSH_DIR}"/id_rsa
PUBLIC_KEY_FILE="${SSH_DIR}"/id_rsa.pub

if [[ -f ${PRIVATE_KEY_FILE} ]]; then
  zenity --info --title="SSH" --text="Your RSA key is already generated. Remove it if you want to generate new key." --width=200 --height=50
else
  mkdir -p "${SSH_DIR}"

  while [[ -z ${SSH_PASSPHRASE} ]]; do
    SSH_PASSPHRASE=$(password_input "Enter your RSA key passphrase")
  done
  ssh-keygen -q -t rsa -N "${SSH_PASSPHRASE}" -o -a 100 -b 4096 -f "${PRIVATE_KEY_FILE}"
fi

if [[ -f ${PUBLIC_KEY_FILE} ]]; then
  PUBLIC_KEY=$(cat "${PUBLIC_KEY_FILE}")
  zenity --entry --title="SSH" --text="This is your Public key, paste it into Git repositories" --entry-text="${PUBLIC_KEY}" || true
fi
### END Generate SSH key
