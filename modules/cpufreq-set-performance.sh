#!/usr/bin/env bash

if ! grep --quiet 'GOVERNOR="performance"' /etc/default/cpufrequtils; then
    echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
fi

sudo systemctl disable ondemand