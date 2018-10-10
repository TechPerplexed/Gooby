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

		docker run -p \
		--name=organizr \
		--restart=always \
		-v /home/GooPlex/Organizr/config:/config \
		-e PGID=1000 -e PUID=1000 \
		-p 80:80 \
		lsiocommunity/organizr
		
		sudo chown -R $USER:$USER $CONFIGS

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
