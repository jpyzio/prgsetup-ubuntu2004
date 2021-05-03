#!/usr/bin/env bash

apt purge --yes docker docker.io containerd runc

curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable"

apt update
apt install --yes docker-ce docker-ce-cli containerd.io

echo '{"storage-driver": "overlay2", "dns": ["8.8.8.8", "8.8.4.4"], "features" : {"buildkit" : true}}' > /etc/docker/daemon.json
usermod --append --groups docker "${USER_NAME}"
systemctl enable docker
service docker restart

echo -e "\e[31mWARNING!!! Before you use the docker command without \"sudo\", please restart the system!\e[39m"

SHOULD_REBOOT=true