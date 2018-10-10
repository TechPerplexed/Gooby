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

sudo rm -r /opt/GooPlex
sudo git clone https://github.com/TechPerplexed/GooPlex.git /opt/GooPlex
sudo bash /opt/GooPlex/install/gooplex

sudo chmod +x -R /opt/GooPlex/install
sudo chmod +x -R /opt/GooPlex/menus
sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo chmod 755 /bin/gooplex
