#!/bin/bash

source /opt/Gooby/menus/variables.sh
source $CONFIGS/Docker/.env

echo
echo "${LYELLOW}${LYELLOW}Taking containers and services down${STD}"
echo

cd $CONFIGS/Docker
/usr/local/bin/docker-compose down

sudo systemctl daemon-reload
if [ -f /etc/systemd/system/rclone.service ]; then sudo systemctl stop rclone; fi
if [ -f /etc/systemd/system/rclonefs.service ]; then sudo systemctl stop mergerfs; sudo systemctl stop rclonefs; fi

echo
echo "${LYELLOW}Making sure components are up to date${STD}"
echo

sudo rm -r /opt/Gooby
sudo git clone -b rcleantest https://github.com/TechPerplexed/Gooby /opt/Gooby
sudo chmod +x -R /opt/Gooby/install
sudo chmod +x -R /opt/Gooby/menus
sudo chmod +x -R /opt/Gooby/scripts/cron
sudo rsync -a /opt/Gooby/install/gooby /bin
sudo chmod 755 /bin/gooby

sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components

echo
echo "${LYELLOW}Update Rclone${STD}"
echo

touch $TCONFIGS/rclonev
if [ $( cat $TCONFIGS/rclonev ) = "Stable" ]; then
	curl https://rclone.org/install.sh | sudo bash
elif [ $( cat $TCONFIGS/rclonev ) = "Beta" ]; then
	curl https://rclone.org/install.sh | sudo bash -s beta
fi

echo
echo "${LYELLOW}Bringing services back online${STD}"
echo

sudo rmdir ${RCLONEMOUNT} > /dev/null 2>&1
sudo rmdir ${MOUNTTO} > /dev/null 2>&1
rm ${LOGS}/*.? > /dev/null
echo -n > ${LOGS}/rclone.log

sudo mkdir -p ${RCLONEMOUNT} ${MOUNTTO}
sudo chown -R $USER:$USER $RCLONEMOUNT $MOUNTTO

if [ -f /etc/systemd/system/rclone.service ]; then sudo systemctl start rclone; fi
if [ -f /etc/systemd/system/rclonefs.service ]; then sudo systemctl start rclonefs; sleep 10; sudo systemctl start mergerfs; fi

echo
echo "${LYELLOW}Checking for updated containers${STD}"
echo

docker system prune -a -f --volumes

source /opt/Gooby/install/misc/environment-build.sh rebuild
/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

cd ${CURDIR}

echo
echo "${LYELLOW}${LYELLOW}Patching server${STD}"
echo

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean
sudo apt-get autoremove

echo
echo "${GREEN}Your system should be back online${STD}"
echo

echo "${LYELLOW}Restoring permissions... this could take a few minutes${STD}"
echo

sudo chown -R $USER:$USER $TCONFIGS $HOME $CONFIGS/Certs $CONFIGS/Docker $CONFIGS/Security
