#!/usr/bin/env bash

if ! which git > /dev/null; then
	source "${MODULES_DIR}/git.sh"
fi

while [[ -z ${REAL_NAME} ]]; do
    REAL_NAME=$(text_input "Git Global - Your real full name:")
done
run_as_user git config --global user.name "${REAL_NAME}"


while [[ -z ${EMAIL} ]]; do
    EMAIL=$(text_input "Git Global - Your Email:")
done
run_as_user git config --global user.email "${EMAIL}"


PUSH_DEFAULT=$(text_input "Git Global - Push default: [current]")
if [[ -z ${PUSH_DEFAULT} ]]; then
    PUSH_DEFAULT='current'
fi
run_as_user git config --global push.default "${PUSH_DEFAULT}"

if ! grep --quiet 'excludesfile' ~/.gitconfig ; then
    run_as_user git config --global core.excludesfile "${ROOT_DIR}/.gitignore_global"
fi
