#!/usr/bin/env bash

which spotify > /dev/null
if [[ "${?}" == "1" ]]; then
    snap install spotify
fi
