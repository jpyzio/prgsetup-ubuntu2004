#!/usr/bin/env bash

which spotify > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo snap install spotify
fi