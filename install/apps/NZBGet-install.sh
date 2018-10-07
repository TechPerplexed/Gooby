#!/bin/bash

ls /opt/nzbget > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Open ports

		sudo ufw allow 6789

		# Dependencies

		sudo apt-get upgrade -y && sudo apt-get upgrade -y

		# Main script

		cd /tmp
		sudo wget https://nzbget.net/download/nzbget-latest-bin-linux.run
		sudo sh nzbget-latest-bin-linux.run --destdir /opt/nzbget
		sudo chown -R plexuser:plexuser /opt/nzbget

		# Installing Services

		sudo rsync -a /opt/GooPlex/scripts/nzbget.service /etc/systemd/system/nzbget.service
		sudo systemctl enable nzbget.service
		sudo systemctl daemon-reload
		sudo systemctl start nzbget.service

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
