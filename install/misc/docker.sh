#!/bin/bash

# For future use

sudo apt-get -y install \
    apt-transport-https \
    acl \
    ca-certificates \
    curl \
    software-properties-common

sudo apt-get purge apparmor -y
 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get -y update
sudo apt-get -y install docker-ce
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.19.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

sudo gpasswd -a $USER docker
sudo setfacl -m user:$USER:rw /var/run/docker.sock
