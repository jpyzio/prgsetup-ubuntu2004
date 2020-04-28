#!/usr/bin/env bash

### BEGIN Open SSH Server
sudo apt install --yes openssh-server
### END Open SSH Server

### BEGIN Open SSH Server config
sudo sed --in-place --regexp-extended "s/.*PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*PermitEmptyPasswords.*/PermitEmptyPasswords no/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*ClientAliveInterval.*/ClientAliveInterval 600/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*ClientAliveCountMax.*/ClientAliveCountMax 0/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*X11Forwarding.*/X11Forwarding no/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*Banner.*/Banner none/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*IgnoreRhosts.*/IgnoreRhosts yes/g" /etc/ssh/sshd_config
sudo sed --in-place --regexp-extended "s/.*HostbasedAuthentication.*/HostbasedAuthentication no/g" /etc/ssh/sshd_config

sudo service ssh restart
### END Open SSH Server config
