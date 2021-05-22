#!/usr/bin/env bash

if ! which zsh > /dev/null; then
    apt install --yes zsh
    run_as_user chsh --shell $(which zsh)

    SHOULD_REBOOT=true
fi
