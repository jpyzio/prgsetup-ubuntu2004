#!/usr/bin/env bash

### BEGIN Slack
which slack > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo snap install slack --classic
fi
### END Slack

### BEGIN Thunderbird
which thunderbird > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo apt install --yes thunderbird
fi
### END Thunderbird
