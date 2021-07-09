#!/usr/bin/env bash

SWAP_FILE='/swapfile'
FSTAB_FILE='/etc/fstab'

if swapon -s | grep -q "${SWAP_FILE}"; then
    swapoff "${SWAP_FILE}"
fi

if grep "${SWAP_FILE}" "${FSTAB_FILE}"; then
    sed -i "/^\\${SWAP_FILE}.*/d" "${FSTAB_FILE}"
fi

if [[ -f "${SWAP_FILE}" ]]; then
    rm "${SWAP_FILE}"
fi

while ! echo "${SWAP_SIZE}" | grep -qE '^[0-9]+$'; do
    SWAP_SIZE=$(text_input "SWAP size in GB (0 = no SWAP)")
done

if [[ "${SWAP_SIZE}" -gt 0 ]]; then
    fallocate -l "${SWAP_SIZE}G" "${SWAP_FILE}"
    chmod 600 "${SWAP_FILE}"
    mkswap "${SWAP_FILE}"
    swapon "${SWAP_FILE}"

    echo "${SWAP_FILE} swap swap defaults 0 0" >> "${FSTAB_FILE}"
fi