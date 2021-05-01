#!/usr/bin/env bash

if ! which git > /dev/null; then
	source "${MODULES_DIR}/git.sh"
fi

USER_GIT_TEMPLATES_DIR="${HOME}/.git-templates"
USER_GIT_HOOKS_DIR="${USER_GIT_TEMPLATES_DIR}/hooks"

run_as_user git config --global init.templatedir "${USER_GIT_TEMPLATES_DIR}"

run_as_user mkdir --parents "${USER_GIT_HOOKS_DIR}"
chmod +x "${USER_GIT_HOOKS_DIR}"/*