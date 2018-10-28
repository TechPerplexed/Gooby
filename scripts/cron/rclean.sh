#!/bin/bash

source /opt/Gooby/menus/variables.sh

echo "${LYELLOW}${LYELLOW}Taking containers down${STD}"
echo

cd $CONFIGS/Docker
/usr/local/bin/docker-compose down

echo "${LYELLOW}Taking services down${STD}"
echo

sudo systemctl daemon-reload
# sudo systemctl stop mergerfs
sudo systemctl stop rclone

echo "${LYELLOW}Making sure components are up to date${STD}"
echo

sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components

echo "${LYELLOW}Update Rclone${STD}"
echo

touch $TCONFIGS/rclonev
if [ $( cat $TCONFIGS/rclonev ) = "Stable" ]; then
	curl https://rclone.org/install.sh | sudo bash
elif [ $( cat $TCONFIGS/rclonev ) = "Beta" ]; then
	curl https://rclone.org/install.sh | sudo bash -s beta
fi

echo "${LYELLOW}Starting services${STD}"
echo

sudo systemctl start rclone
sleep 10
# sudo systemctl start mergerfs

echo "${LYELLOW}Pruning old volumes${STD}"
echo

docker system prune -a -f --volumes

echo "${LYELLOW}Bringing system back online${STD}"
echo

source /opt/Gooby/install/misc/environment-build.sh rebuild
/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

echo "${LYELLOW}Restoring permissions... this could take a few minutes${STD}"
echo

sudo chown -R $USER:$USER $CONFIGS
sudo chown -R $USER:$USER $TCONFIGS
sudo chown -R $USER:$USER $HOME
cd "${CURDIR}"
