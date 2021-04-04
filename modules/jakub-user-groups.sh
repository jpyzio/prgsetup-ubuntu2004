#!/usr/bin/env bash

for GROUP in video kvm www-data plugdev sambashare lpadmin adm sudo dialout ; do
    groups | grep "${GROUP}" --quiet
    if [[ "${?}" == "1" ]]; then # The user does not belong to the group
        cut -d: -f1 /etc/group | tr '\n' ' ' | grep "${GROUP}" --quiet
        if [[ "${?}" == "0" ]]; then # The group exists
            sudo usermod --append --groups "${GROUP}" "${USER}"
        fi
    fi
done
