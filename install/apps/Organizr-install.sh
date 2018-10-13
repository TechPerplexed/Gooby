#!/bin/bash

APP="organizr"
PORT=" "

docker ps -q -f name=$APP > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Dependencies

		source /opt/GooPlex/install/server/docker-install.sh

		# Main script

		docker run -d \
		--name=$APP \
		--restart=always \
		-v $CONFIGS/$APP:/config \
		-e PGID=$GROUPID -e PUID=$USERID \
		-p "80:80" \
		lsiocommunity/organizr

		sudo chown -R $USER:$USER $CONFIGS/$APP
		
		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
