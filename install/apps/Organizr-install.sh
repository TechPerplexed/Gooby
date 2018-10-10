#!/bin/bash

docker ps -q -f name=organizr > /tmp/checkapp.txt
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

		source /opt/GooPlex/install/misc/docker.sh

		# Main script

		docker create --name=organizr \
		--name=organizr \
		--restart=always \
		-v $CONFIGS/Organizr/config:/config \
		-e PGID=$GROUPID -e PUID=$USERID  \
		-p 80:80 \
		lsiocommunity/organizr

		docker start organizr
		
		sudo chown -R $USER:$USER $CONFIGS

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
