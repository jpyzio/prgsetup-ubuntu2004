#!/usr/bin/env bash

### BEGIN Android
sudo apt install --yes qemu-kvm

groups | grep kvm --quiet
if [[ ${?} == "1" ]]; then
  sudo adduser "${USER}" kvm
fi
#sudo chown "${USER}" /dev/kvm
