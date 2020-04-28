#!/usr/bin/env bash

### BEGIN Git and tools
sudo apt install --yes git gitk tig
### END Git and tools

### BEGIN Git configuration
while [[ -z ${REAL_NAME} ]]; do
  REAL_NAME=$(text_input "Git Global - Your real full name:")
done

while [[ -z ${EMAIL} ]]; do
  EMAIL=$(text_input "Git Global - Your Email:")
done

git config --global user.name "${REAL_NAME}"
git config --global user.email "${EMAIL}"

git config --global push.default current

echo -e "npm-debug.log\n.DS_Store\nThumbs.db\n.idea/\n*~\n*.log\n/vendor/\n*.tmp" | tee --append ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
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
