#!/usr/bin/env bash

sudo apt install --yes qemu-kvm

if groups | grep kvm --quiet; then
    sudo adduser "${USER}" kvm
fi