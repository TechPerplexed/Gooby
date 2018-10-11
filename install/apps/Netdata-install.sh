#!/bin/bash

APP="netdata"
PORT="19999"

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

		source /opt/GooPlex/install/misc/docker.sh

		# Main script

		docker run -d --name=$APP \
		--restart=always \
		-p $PORT:$PORT \
		-v /proc:/host/proc:ro \
		-v /sys:/host/sys:ro \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		--cap-add SYS_PTRACE \
		--security-opt apparmor=unconfined \
		netdata/netdata

		sudo chown -R $USER:$USER $CONFIGS/$APP
		
		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
