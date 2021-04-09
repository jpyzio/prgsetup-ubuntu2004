#!/usr/bin/env bash

for GROUP in video kvm www-data plugdev sambashare lpadmin adm sudo dialout ; do
    groups | grep --quiet "${GROUP}"
    if [[ "${?}" == "1" ]]; then # The user does not belong to the group
        if cut -d: -f1 /etc/group | tr '\n' ' ' | grep --quiet "${GROUP}"; then # The group exists
            sudo usermod --append --groups "${GROUP}" "${USER}"
        fi
    fi
done
