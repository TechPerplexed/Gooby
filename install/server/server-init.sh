#!/bin/bash

source /opt/Gooby/menus/variables.sh

clear
echo ""
echo "${YELLOW}Welcome to Gooby $VERSION!${STD}"
echo ""
echo "You will need to own a domain... if you don't have one"
echo "Then you get can a free domain for example at Freenom."
echo ""
echo "${YELLOW}Please answer the following two questions:${STD}"
echo ""
echo "What domain will you be using to access your server?"
read -e -p '(ex: mydomain.com)  ' -i "${MYDOMAIN}" MYDOMAIN
echo ""
echo "What is your email address for certificate registration?"
read -e -p '(ex: myname@mydomain.com)  ' -i "${MYEMAIL}" MYEMAIL
echo ""
echo "${YELLOW}Thank you! Please hang tight while we get some things ready...${STD}"
echo "" && sleep 10
source /opt/Gooby/install/server/docker-install.sh
sudo mkdir -p $CONFIGS/.config
sudo mkdir -p $TCONFIGS
sudo mkdir -p $CONFIGS/Docker/components
sudo chown -R $USER:$USER $CONFIGS
sudo chown -R $USER:$USER $TCONFIGS
echo "$MYDOMAIN" > $CONFIGS/.config/mydomain
echo "$MYEMAIL" > $CONFIGS/.config/myemail
sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components
touch $CONFIGS/.config/rcloneservice $CONFIGS/.config/rclonefolder
source /opt/Gooby/install/misc/environment-build.sh
cd $CONFIGS/Docker; /usr/local/bin/docker-compose up -d --remove-orphans ${@:2}; cd "${CURDIR}"
