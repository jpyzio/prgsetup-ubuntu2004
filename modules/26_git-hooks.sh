#!/usr/bin/env bash

HOOKS_DIR="${ROOT_DIR}/git_hooks"
USER_GIT_TEMPLATES_DIR="${HOME}/.git-templates"
USER_GIT_HOOKS_DIR="${USER_GIT_TEMPLATES_DIR}/hooks"

git config --global init.templatedir "${USER_GIT_TEMPLATES_DIR}"

mkdir --parents "${USER_GIT_HOOKS_DIR}"

curl https://cdn.rawgit.com/tommarshall/git-good-commit/v0.6.1/hook.sh >"${USER_GIT_HOOKS_DIR}"/commit-msg
cp "${HOOKS_DIR}"/* "${USER_GIT_HOOKS_DIR}"/

chmod +x "${USER_GIT_HOOKS_DIR}"/*