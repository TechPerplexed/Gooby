#!/bin/bash

source /opt/Gooby/menus/variables.sh

echo Taking containers down

cd $CONFIGS/Docker
/usr/local/bin/docker-compose down

echo Taking services down

sudo systemctl daemon-reload
# sudo systemctl stop mergerfs
sudo systemctl stop rclone

echo Making sure components are up to date

sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components

# Update Rclone to latest version

touch $TCONFIGS/rclonev
if [ $( cat $TCONFIGS/rclonev ) = "Stable" ]; then
	curl https://rclone.org/install.sh | sudo bash
elif [ $( cat $TCONFIGS/rclonev ) = "Beta" ]; then
	curl https://rclone.org/install.sh | sudo bash -s beta
fi

echo Bringing services back up

sudo systemctl start rclone
sleep 10
# sudo systemctl start mergerfs

echo Updating containers to the latest version

docker system prune -a -f --volumes
source /opt/Gooby/install/misc/environment-build.sh rebuild
/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

echo Restoring permissions

sudo chown -R $USER:$USER $CONFIGS
sudo chown -R $USER:$USER $TCONFIGS
sudo chown -R $USER:$USER $HOME
cd "${CURDIR}"

echo Finalizing
