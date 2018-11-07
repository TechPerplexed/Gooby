#!/bin/bash

source /opt/Gooby/menus/variables.sh

echo
echo "${LYELLOW}${LYELLOW}Taking containers down${STD}"
echo

cd $CONFIGS/Docker
/usr/local/bin/docker-compose down

echo
echo "${LYELLOW}Taking services down${STD}"
echo

sudo systemctl daemon-reload

if [ -e /etc/systemd/system/mergerfs.service ]; then sudo systemctl stop mergerfs; fi
if [ -e /etc/systemd/system/rclonefs.service ]; then sudo systemctl stop rclonefs; fi
if [ -e /etc/systemd/system/rclone.service ]; then sudo systemctl stop rclone; fi

echo
echo "${LYELLOW}Making sure components are up to date${STD}"
echo

sudo rm -r /opt/Gooby
sudo git clone -b master https://github.com/TechPerplexed/Gooby /opt/Gooby
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
echo "${LYELLOW}Starting services${STD}"
echo

if [ -e /etc/systemd/system/rclone.service ]; then sudo systemctl start rclone; fi
if [ -e /etc/systemd/system/rclonefs.service ]; then sudo systemctl start rclonefs; fi
sleep 10
if [ -e /etc/systemd/system/mergerfs.service ]; then sudo systemctl start mergerfs; fi

echo
echo "${LYELLOW}Pruning old volumes${STD}"
echo

docker system prune -a -f --volumes

echo
echo "${LYELLOW}Bringing system back online${STD}"
echo

source /opt/Gooby/install/misc/environment-build.sh rebuild
/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

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
echo "${LYELLOW}Restoring permissions... this could take a few minutes${STD}"
echo

sudo chown -R $USER:$USER $CONFIGS
sudo chown -R $USER:$USER $TCONFIGS
sudo chown -R $USER:$USER $HOME
cd ${CURDIR}
