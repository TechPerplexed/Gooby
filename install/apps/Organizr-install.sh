#!/bin/bash

ls /opt/OrganizrInstaller > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Main script

		docker create --name=organizr \
		--name=organizr \
		--restart=always \
		-v /home/docker/organizr/config:/config \
		-p 80:80 \
		lsiocommunity/organizr

		docker start organizr

		sudo chown plexuser:plexuser -R /home/plexuser

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
