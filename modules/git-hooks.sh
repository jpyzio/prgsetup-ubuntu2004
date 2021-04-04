#!/usr/bin/env bash

which git > /dev/null
if [[ "${?}" == "1" ]]; then
	source "${MODULES_DIR}/git.sh"
fi

USER_GIT_TEMPLATES_DIR="${HOME}/.git-templates"
USER_GIT_HOOKS_DIR="${USER_GIT_TEMPLATES_DIR}/hooks"

git config --global init.templatedir "${USER_GIT_TEMPLATES_DIR}"

mkdir --parents "${USER_GIT_HOOKS_DIR}"
chmod +x "${USER_GIT_HOOKS_DIR}"/*