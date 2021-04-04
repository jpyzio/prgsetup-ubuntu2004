#!/usr/bin/env bash

sudo apt install --yes qemu-kvm

groups | grep kvm --quiet
if [[ ${?} == "1" ]]; then
    sudo adduser "${USER}" kvm
fi