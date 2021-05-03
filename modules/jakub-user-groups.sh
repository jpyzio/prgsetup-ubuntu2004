#!/usr/bin/env bash

for GROUP in video kvm www-data plugdev sambashare lpadmin adm sudo dialout; do
    if ! groups | grep --quiet "${GROUP}"; then # The user does not belong to the group
        if cut -d: -f1 /etc/group | tr '\n' ' ' | grep --quiet "${GROUP}"; then # The group exists
            usermod --append --groups "${USER_NAME}" "${USER_NAME}"
        fi
    fi
done
