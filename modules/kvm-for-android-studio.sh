#!/usr/bin/env bash

sudo apt install --yes qemu-kvm

if groups | grep --quiet kvm; then
    sudo adduser "${USER}" kvm
fi