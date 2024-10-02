#!/usr/bin/env bash

curl -sL https://download.docker.com/linux/ubuntu/gpg \
 -o /etc/apt/keyrings/docker-apt-keyring.asc

cat > /etc/apt/sources.list.d/docker.list <<EOF
deb [arch=amd64 signed-by=/etc/apt/keyrings/docker-apt-keyring.asc] https://download.docker.com/linux/ubuntu $(lsb_release -c -s) stable
EOF

echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export LANG=C.UTF-8

apt update
apt upgrade -yq

apt install -yq \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin \
    apparmor-utils

curl -sL https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker \
    -o /etc/bash_completion.d/docker.sh

# Enable and configure firewall

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
#sudo ufw allow from 147.161.162.190 to any port 22
sudo ufw enable
