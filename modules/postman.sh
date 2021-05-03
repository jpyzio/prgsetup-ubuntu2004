#!/usr/bin/env bash

which postman > /dev/null
if [[ "${?}" == "1" ]]; then
    snap install postman
fi
