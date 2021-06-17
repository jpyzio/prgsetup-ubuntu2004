#!/usr/bin/env bash

while ! echo "${SWAP_SIZE}" | grep -qE '^[0-9]+$'; do
    SWAP_SIZE=$(text_input "SWAP size in GB (only number)")
done

fallocate -l "${SWAP_SIZE}G" /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

swapon --show