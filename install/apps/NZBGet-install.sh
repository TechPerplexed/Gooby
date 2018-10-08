#!/bin/bash

which nzbget > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Open ports

		sudo ufw allow 6789

		# Main script

		cd /tmp
		sudo apt-get -y install nzbget
		sudo chown -R plexuser:plexuser /opt/nzbget

		# Installing Services

		sudo rsync -a /opt/GooPlex/scripts/nzbget.service /etc/systemd/system/nzbget.service
		sudo systemctl enable nzbget.service
		sudo systemctl daemon-reload
		sudo systemctl start nzbget.service

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
