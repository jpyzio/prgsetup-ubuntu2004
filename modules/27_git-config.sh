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


grep 'export PS1' ~/.bashrc >> /dev/null
if [[ "${?}" == "1" ]]; then
  echo "export PS1='\[\033[01;32m\]\h\[\033[01;34m\] \w\[\033[31m\]\$(__git_ps1 \" (%s)\") \[\033[01;34m\]$\[\033[00m\] '" \
  | tee --append ~/.bashrc
fi