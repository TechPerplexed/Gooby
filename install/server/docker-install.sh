#!/bin/bash

VERSION=$(lsb_release -si)
echo Distribution is ${VERSION}

sudo apt -y update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common python3-pip acl

curl -fsSL https://download.docker.com/linux/${VERSION,,}/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/${VERSION,,} $(lsb_release -cs) stable"

sudo apt -y update
apt-cache policy docker-ce
sudo apt install -y docker-ce

# latest docker compose released tag

COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)

# Install docker-compose

sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

sudo usermod -aG docker ${USER}
sudo gpasswd -a ${USER} docker 
sudo setfacl -m user:${USER}:rw /var/run/docker.sock

clear

docker version
echo
docker-compose version
