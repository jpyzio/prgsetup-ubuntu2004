#!/usr/bin/env bash

which slack > /dev/null
if [[ "${?}" == "1" ]]; then
    snap install slack --classic
fi
