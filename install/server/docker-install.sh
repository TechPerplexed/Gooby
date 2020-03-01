#!/bin/bash

VERSION=$(lsb_release -si)
echo Distribution is ${VERSION}

if [[ "$(lsb_release -cs)" == "buster" ]]; then
    echo -ne '                         (0%)\r'
    sudo apt-get update -yqq && apt-get autoremove -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '#####                    (20%)\r'
    sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common python3-pip acl -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '##########                (40%)\r'
    curl -fsSL https://download.docker.com/linux/${VERSION,,}/gpg | sudo apt-key add - >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '###############            (60%)\r'
    sudo apt-get update -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '####################       (80%)\r'
    sudo apt-get install docker-ce docker-ce-cli -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '#########################    (100%)\r'
    echo -ne '\n'
else
    echo -ne '                         (0%)\r'
    sudo apt-get update -yqq && apt-get autoremove -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '#####                    (20%)\r'
    sudo apt install apt-transport-https ca-certificates curl software-properties-common python3-pip acl -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '##########                (40%)\r'
    curl -fsSL https://download.docker.com/linux/${VERSION,,}/gpg | sudo apt-key add - >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '###############            (60%)\r'
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/${VERSION,,} $(lsb_release -cs) stable" >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '####################       (80%)\r'
    sudo apt-get install docker-ce -yqq >/dev/null 2>&1
        export DEBIAN_FRONTEND=noninteractive
    echo -ne '#########################    (100%)\r'
    echo -ne '\n'
fi

checkdocker=$(sudo systemctl status docker | grep "Active:" | awk '{print $2}')

if [[ ${checkdocker} != "active" ]]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
else 
   echo "Docker Installed - docker vesion = $(docker --version)"
fi

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
