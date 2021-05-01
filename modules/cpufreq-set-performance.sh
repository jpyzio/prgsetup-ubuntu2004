#!/usr/bin/env bash

if ! grep --quiet 'GOVERNOR="performance"' /etc/default/cpufrequtils; then
    echo 'GOVERNOR="performance"' > /etc/default/cpufrequtils
fi

systemctl disable ondemand