#!/usr/bin/env bash

### BEGIN Git and tools
sudo apt install --yes git gitk tig
### END Git and tools

### BEGIN Git configuration
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

### END Git configuration

### BEGIN Git hooks
HOOKS_DIR="${ROOT_DIR}/git_hooks"
USER_GIT_TEMPLATES_DIR="${HOME}/.git-templates"
USER_GIT_HOOKS_DIR="${USER_GIT_TEMPLATES_DIR}/hooks"

git config --global init.templatedir "${USER_GIT_TEMPLATES_DIR}"

mkdir --parents "${USER_GIT_HOOKS_DIR}"

curl https://cdn.rawgit.com/tommarshall/git-good-commit/v0.6.1/hook.sh >"${USER_GIT_HOOKS_DIR}"/commit-msg
cp "${HOOKS_DIR}"/* "${USER_GIT_HOOKS_DIR}"/

chmod +x "${USER_GIT_HOOKS_DIR}"/*
### END Git hooks
