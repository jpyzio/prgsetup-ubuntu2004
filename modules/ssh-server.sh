#!/usr/bin/env bash

apt install --yes openssh-server

sed --in-place --regexp-extended "s/.*PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*PermitEmptyPasswords.*/PermitEmptyPasswords no/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*ClientAliveInterval.*/ClientAliveInterval 600/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*ClientAliveCountMax.*/ClientAliveCountMax 0/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*X11Forwarding.*/X11Forwarding no/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*Banner.*/Banner none/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*IgnoreRhosts.*/IgnoreRhosts yes/g" /etc/ssh/sshd_config
sed --in-place --regexp-extended "s/.*HostbasedAuthentication.*/HostbasedAuthentication no/g" /etc/ssh/sshd_config

service ssh restart

if which ufw > /dev/null; then
    ufw allow ssh
fi
