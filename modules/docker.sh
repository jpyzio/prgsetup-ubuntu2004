#!/usr/bin/env bash

### BEGIN Docker
sudo apt purge --yes docker docker.io containerd runc
sudo apt install --yes apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable"

sudo apt update
sudo apt install --yes docker-ce docker-ce-cli containerd.io

echo '{"dns": ["8.8.8.8", "8.8.4.4"]}' | sudo tee /etc/docker/daemon.json
sudo systemctl enable docker

sudo usermod --append --groups docker "${USER}"

sudo docker run hello-world

echo -e "\e[31mWARNING!!! Before you use the docker command without \"sudo\", please restart the system!\e[39m"
### END Docker

### BEGIN Docker Compose
sudo curl --location "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname --kernel-name)-$(uname --machine)" --output /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln --symbolic /usr/local/bin/docker-compose /usr/bin/docker-compose
### END Docker Compose
