#!/bin/bash

source /opt/Gooby/menus/variables.sh

cd $CONFIGS/Docker
/usr/local/bin/docker-compose down
sudo systemctl daemon-reload
# sudo systemctl stop mergerfs
sudo systemctl stop rclone

touch $TCONFIGS/rclonev
if [ $( cat $TCONFIGS/rclonev ) = "Release" ]; then
	curl https://rclone.org/install.sh | sudo bash
elif [ $( cat $TCONFIGS/rclonev ) = "Beta" ]; then
	curl https://rclone.org/install.sh | sudo bash -s beta
fi

sudo systemctl start rclone
sleep 10
# sudo systemctl start mergerfs

docker system prune -a -f --volumes
source /opt/Gooby/install/misc/environment-build.sh rebuild
/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

sudo chown -R $USER:$USER $CONFIGS
sudo chown -R $USER:$USER $TCONFIGS
sudo chown -R $USER:$USER $HOME
cd "${CURDIR}"
