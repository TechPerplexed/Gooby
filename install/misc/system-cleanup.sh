#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	echo ""
	echo "Giving your system a nice little spring cleaning..."
	echo ""

	cd $CONFIGS/Docker
	/usr/local/bin/docker-compose down
	sudo systemctl daemon-reload
	# sudo systemctl stop mergerfs
	sudo systemctl stop rclone

	sudo systemctl start rclone
	sleep 10
	# sudo systemctl start mergerfs

	docker system prune -a -f --volumes
	source /opt/GooPlex/install/misc/environment-build.sh rebuild
	/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

	sudo chown -R $USER:$USER $CONFIGS
	sudo chown -R $USER:$USER $HOME
	cd "${CURDIR}"

	clear

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
