#!/usr/bin/env bash

### BEGIN Check system
UBUNTU_VERSION=$(lsb_release --release --short)

if [[ "${UBUNTU_VERSION}" != "${CONFIGURATOR_VERSION}" ]]; then
  echo -e "\e[31mERROR: This configurator is only for Ubuntu ${CONFIGURATOR_VERSION}\e[39m"
  exit 1
fi
### END Check system
