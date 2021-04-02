#!/usr/bin/env bash

while [[ -z ${REAL_NAME} ]]; do
  REAL_NAME=$(text_input "Git Global - Your real full name:")
done
git config --global user.name "${REAL_NAME}"


while [[ -z ${EMAIL} ]]; do
  EMAIL=$(text_input "Git Global - Your Email:")
done
git config --global user.email "${EMAIL}"


PUSH_DEFAULT=$(text_input "Git Global - Push default: [current]")
if [[ -z ${PUSH_DEFAULT} ]]; then
  PUSH_DEFAULT='current'
fi
git config --global push.default "${PUSH_DEFAULT}"


git config --global core.excludesfile "${ROOT_DIR}/.gitignore_global"
