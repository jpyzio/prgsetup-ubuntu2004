#!/usr/bin/env bash

### BEGIN Android
sudo apt install --yes qemu-kvm

sudo adduser "${USER}" kvm
#sudo chown "${USER}" /dev/kvm
