#!/bin/bash

VERSION=2.2.1

source /opt/Gooby/menus/variables.sh

clear
echo
echo "${YELLOW}Welcome to Gooby $VERSION!${STD}"
echo
echo "${YELLOW}Please answer the following two questions:${STD}"
echo
echo "What domain will you be using to access your server?"
read -e -p '(ex: mydomain.com)  ' -i "${MYDOMAIN}" MYDOMAIN
echo
echo "What is your email address for certificate registration?"
read -e -p '(ex: myname@mydomain.com)  ' -i "${MYEMAIL}" MYEMAIL
echo
echo "${YELLOW}Thank you! Please hang tight while we get some things ready...${STD}"
echo
sleep 10

source /opt/Gooby/install/server/docker-install.sh

sudo mkdir -p ${CONFIGVARS} $CONFIGS/Docker/components 
sudo chown -R $USER:$USER $CONFIGS

echo "$MYDOMAIN" > ${CONFIGVARS}/mydomain
echo "$MYEMAIL" > ${CONFIGVARS}/myemail
echo "master"  > ${CONFIGVARS}/goobybranch

sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components
touch ${CONFIGVARS}/cf_email ${CONFIGVARS}/cf_key ${CONFIGVARS}/plexclaim ${CONFIGVARS}/proxyversion ${CONFIGVARS}/rclonefolder ${CONFIGVARS}/rcloneservice ${CONFIGVARS}/rcloneversion

source /opt/Gooby/install/misc/environment-build.sh

cd $CONFIGS/Docker
/usr/local/bin/docker-compose up --remove-orphans --build -d
cd "${CURDIR}"

sudo chown -R $USER:$USER $CONFIGS $HOME

# Add rlean to bootup cron

crontab -l | grep 'rclean.sh' || (crontab -l 2>/dev/null; echo "@reboot /opt/Gooby/scripts/cron/rclean.sh > /dev/null 2>&1") | crontab -

# Add Gooby version

echo ${VERSION} > ${CONFIGVARS}/version
