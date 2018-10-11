#!/bin/bash

# Install GooPlex

sudo apt-get update -y && sudo apt-get upgrade -y

sudo -s apt-get -y install \
	git \
	fail2ban \
	nano \
	unzip \
	wget \
	curl \
	ufw \
	socat \
	fuse \
	apt-transport-https \
	acl \
	ca-certificates \
denyhosts at sudo software-properties-common

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
# sudo ufw --force enable

sudo rm -r /opt/GooPlex
sudo git clone https://github.com/TechPerplexed/GooPlex.git /opt/GooPlex

sudo chmod +x -R /opt/GooPlex/install
sudo chmod +x -R /opt/GooPlex/menus
sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo mkdir -p /var/local/GooPlex
sudo chmod 755 /bin/gooplex
sudo mkdir -p /home/GooPlex

gooplex
