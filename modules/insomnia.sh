#!/usr/bin/env bash

which insomnia > /dev/null
if [[ "${?}" == "1" ]]; then
    snap install insomnia
fi