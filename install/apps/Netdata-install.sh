#!/bin/bash

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

PAUSE
