#!/bin/bash

source /opt/Gooby/menus/variables.sh

# Take containers down
cd $CONFIGS/Docker
/usr/local/bin/docker-compose down

# Take services down
sudo systemctl daemon-reload
# sudo systemctl stop mergerfs
sudo systemctl stop rclone

# Make sure components are up to date
sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components

# Update Rclone to latest version
touch $TCONFIGS/rclonev
if [ $( cat $TCONFIGS/rclonev ) = "Stable" ]; then
	curl https://rclone.org/install.sh | sudo bash
elif [ $( cat $TCONFIGS/rclonev ) = "Beta" ]; then
	curl https://rclone.org/install.sh | sudo bash -s beta
fi

# Bring services up
sudo systemctl start rclone
sleep 10
# sudo systemctl start mergerfs

# Update containers to the latest version
docker system prune -a -f --volumes
source /opt/Gooby/install/misc/environment-build.sh rebuild
/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

# Set permissions
sudo chown -R $USER:$USER $CONFIGS
sudo chown -R $USER:$USER $TCONFIGS
sudo chown -R $USER:$USER $HOME
cd "${CURDIR}"
