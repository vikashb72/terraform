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
    apparmor-utils \
    sshguard

curl -sL https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker \
    -o /etc/bash_completion.d/docker.sh

# Enable and configure firewall
ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH
ufw --force enable

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

# Configure ufw for sshguard
LINES=$(cat /etc/ufw/before.rules | wc -l)
NEEDED=$((LINES-2))
head -n ${NEEDED} /etc/ufw/before.rules > /tmp/ufw-before.rules

cat <<EOT >> /tmp/ufw-before.rules
# for ipv4
:sshguard - [0:0]
-A ufw-before-input -p tcp --dport 22 -j sshguard
# for ipv6
:sshguard - [0:0]
-A ufw6-before-input -p tcp --dport 22 -j sshguard

# don't delete the 'COMMIT' line or these rules won't be processed
COMMIT
EOT
reboot
