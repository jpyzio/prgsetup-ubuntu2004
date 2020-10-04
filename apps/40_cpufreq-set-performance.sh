#!/usr/bin/env bash

grep 'GOVERNOR="performance"' /etc/default/cpufrequtils --quiet
if [[ "${?}" == "1" ]]; then
  echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
fi

sudo systemctl disable ondemand