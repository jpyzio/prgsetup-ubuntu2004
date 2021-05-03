#!/usr/bin/env bash

if ! which thunderbird > /dev/null; then
    apt install --yes thunderbird
fi
