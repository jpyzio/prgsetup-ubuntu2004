#!/usr/bin/env bash

if ! which obs > /dev/null; then
    add-apt-repository --yes ppa:obsproject/obs-studio
    apt install --yes obs-studio
fi