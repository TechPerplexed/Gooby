#!/bin/bash

docker ps -a -f "name=netdata" > /tmp/checkapp.txt
clear

if read -r && read -r; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Dependencies

		source /opt/GooPlex/install/misc/docker.sh
		docker container stop netdata
		docker container rm netdata

		# Main script

		sudo docker run -d --name=netdata \
		--restart=always \
		-p 19999:19999 \
		-v /proc:/host/proc:ro \
		-v /sys:/host/sys:ro \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		--cap-add SYS_PTRACE \
		--security-opt apparmor=unconfined \
		netdata/netdata

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi /tmp/checkapp.txt

rm /tmp/checkapp.txt
PAUSE
