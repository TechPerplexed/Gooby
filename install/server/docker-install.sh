#!/bin/bash

VERSION=$(lsb_release -si)
echo Distribution is ${VERSION}

sudo apt update > /dev/null 2>&1
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common python3-pip acl > /dev/null 2>&1

curl -fsSL https://download.docker.com/linux/${VERSION,,}/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/${VERSION,,} $(lsb_release -cs) stable"

sudo apt update > /dev/null 2>&1
apt-cache policy docker-ce
sudo apt install -y docker-ce > /dev/null 2>&1

# Install docker-compose

sudo -H pip3 install --upgrade pip
sudo -H  pip install --upgrade docker-compose

sudo usermod -aG docker ${USER}
sudo gpasswd -a ${USER} docker 
sudo setfacl -m user:${USER}:rw /var/run/docker.sock

clear

docker version
echo
docker-compose version
