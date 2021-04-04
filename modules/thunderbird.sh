#!/usr/bin/env bash

which thunderbird > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo apt install --yes thunderbird
fi