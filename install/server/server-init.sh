#!/bin/bash

source /opt/GooPlex/menus/variables.sh

clear
echo ""
echo "${YELLOW}Welcome to GooPlex $VERSION!${STD}"
echo ""
echo "You will need to own a domain... if you don't have one"
echo "You get can a free domain at Freenom."
echo ""
echo "${YELLOW}Please answer the following two questions:${STD}"
echo ""
read -e -p 'What ${YELLOW}domain${STD} will you be using to access your server (ex: mydomain.com)?  ' -i "${MYDOMAIN}" MYDOMAIN
read -e -p 'What is your ${YELLOW}email${STD} address for certificate registration (ex: myname@mydomain.com)  ' -i "${MYEMAIL}" MYEMAIL
echo ""
echo "${YELLOW}Thank you! Please hang tight while we get some things ready...${STD}"
echo "" && sleep 10
source /opt/GooPlex/install/server/docker-install.sh
sudo mkdir -p $CONFIGS/.config
sudo mkdir -p $CONFIGS/Docker/components
sudo chown -R $USER:$USER $CONFIGS
echo "$MYDOMAIN" > $CONFIGS/.config/mydomain
echo "$MYEMAIL" > $CONFIGS/.config/myemail
sudo rsync -a /opt/GooPlex/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components
source /opt/GooPlex/install/misc/environment-build.sh
