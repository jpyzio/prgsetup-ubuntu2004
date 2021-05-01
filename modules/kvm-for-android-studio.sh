#!/usr/bin/env bash

apt install --yes qemu-kvm

if groups | grep --quiet kvm; then
    adduser "${USER}" kvm
fi