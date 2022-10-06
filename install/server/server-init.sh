#!/bin/bash

source /opt/Gooby/menus/variables.sh

# Make it yours

clear
echo
echo "${YELLOW}Welcome to ${GOOBY}${YELLOW}!"
echo
echo "Please answer the following two questions:${STD}"
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

# Install Docker

source /opt/Gooby/install/server/docker-install.sh

# Save parameters

sudo mkdir -p ${CONFIGVARS} ${CONFIGS}/Docker/components 
sudo chown -R ${USER}:${USER} ${CONFIGS}

echo "${MYDOMAIN}" > ${CONFIGVARS}/mydomain
echo "${MYEMAIL}" > ${CONFIGVARS}/myemail
echo "v2" > ${CONFIGVARS}/goobybranch

[[ ! -f ${CONFIGVARS}/rootmount ]] && echo "/mnt" > ${CONFIGVARS}/rootmount
[[ ! -f ${CONFIGVARS}/media ]] && echo "/mnt/google" > ${CONFIGVARS}/media
[[ ! -f ${CONFIGVARS}/uploads ]] && echo "/mnt/uploads" > ${CONFIGVARS}/uploads
[[ ! -f ${CONFIGVARS}/localfiles ]] && echo "/mnt/local" > ${CONFIGVARS}/localfiles
[[ ! -f ${CONFIGVARS}/rclonemount ]] && echo "/mnt/rclone" > ${CONFIGVARS}/rclonemount
[[ ! -f ${CONFIGVARS}/rclonepassword ]] && echo "Go0by" > ${CONFIGVARS}/rclonepassword
[[ ! -f ${CONFIGVARS}/rcloneusername ]] && echo "gooby" > ${CONFIGVARS}/rcloneusername
[[ ! -f ${CONFIGVARS}/proxyversion ]] && echo "nginx" > ${CONFIGVARS}/proxyversion

# Copy necessary containers

PROXYVERSION=$(cat ${CONFIGVARS}/proxyversion)

sudo rsync -a /opt/Gooby/scripts/${PROXYVERSION}/{01-header.yaml,02-oauth.yaml,03-proxy.yaml,04-watchtower.yaml,05-autoheal.yaml,99-footer.yaml} ${CONFIGS}/Docker/components
touch ${CONFIGVARS}/cf_email ${CONFIGVARS}/cf_key ${CONFIGVARS}/plexclaim ${CONFIGVARS}/rclonefolder ${CONFIGVARS}/rcloneservice ${CONFIGVARS}/rcloneversion ${CONFIGVARS}/version

# Build server

source /opt/Gooby/install/misc/environment-build.sh

cd ${CONFIGS}/Docker

sudo mkdir nginx
sudo mkdir -p traefik
sudo rsync -a /opt/Gooby/scripts/services/traefik.toml ${CONFIGS}/Docker/traefik/
sudo sed -i "s/GOOBYDOMAIN/${MYDOMAIN}/g" ${CONFIGS}/Docker/traefik/traefik.toml
sudo sed -i "s/GOOBYEMAIL/${MYEMAIL}/g" ${CONFIGS}/Docker/traefik/traefik.toml

# Set permissions

sudo chown -R ${USER}:${USER} ${CONFIGS}

echo "client_max_body_size 30m;" > ${CONFIGS}/Docker/nginx/my_custom_proxy_settings.conf

# Bring containers up

/usr/local/bin/docker-compose up --remove-orphans --build -d

cd "${CURDIR}"

# Add rlean to bootup cron

crontab -l | grep 'rclean.sh' || (crontab -l 2>/dev/null; echo "@reboot /opt/Gooby/scripts/cron/rclean.sh > /dev/null 2>&1") | crontab -
