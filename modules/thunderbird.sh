#!/usr/bin/env bash

which thunderbird > /dev/null
if [[ "${?}" == "1" ]]; then
    apt install --yes thunderbird
fi
