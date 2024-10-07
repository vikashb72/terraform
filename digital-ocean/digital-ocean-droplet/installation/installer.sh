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
sudo ufw --force enable

# Add useraccounts
for ADM in vikash.badal donovan.austin raghuveersingh.choudhari sparsh.sharma
do
    useradd -d /home/${ADM} -G sudo,root,adm -s /bin/bash ${ADM}
    mkdir -p /home/${ADM}/.ssh
    [ -f /tmp/installation/${ADM}.ssh.pub ] \
        && cp /tmp/installation/${ADM}.ssh.pub \
           /home/${ADM}/.ssh/authorized_keys \
        && chmod 644 /home/${ADM}/.ssh/authorized_keys
    chown -R ${ADM} /home/${ADM}/.ssh
done
