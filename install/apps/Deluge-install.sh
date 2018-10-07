#!/bin/bash

which deluged > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Open ports

		sudo ufw allow 8112

		# Dependencies

		sudo apt-get upgrade -y && sudo apt-get upgrade -y

		# Main script

		sudo apt-get -y install \
			deluged \
			deluge-webui \
			deluge-console \
		denyhosts at sudo software-properties-common

		# Installing Services

		sudo rsync -a /opt/GooPlex/scripts/deluged.service /etc/systemd/system/deluged.service
		sudo rsync -a /opt/GooPlex/scripts/deluge-web.service /etc/systemd/system/deluge-web.service

		sudo systemctl enable deluged.service
		sudo systemctl enable deluge-web.service

		sudo systemctl daemon-reload

		sudo systemctl start deluged.service
		sudo systemctl start deluge-web.service

		# Creating Folders

		sudo mkdir -p /home/plexuser/downloads/incomplete
		sudo mkdir -p /home/plexuser/downloads/import
		sudo chown -R plexuser:plexuser /home/plexuser

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
