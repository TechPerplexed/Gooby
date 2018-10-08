#!/bin/bash

ls /opt/nzbget > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 6789

		# Main script

		sudo apt-get purge --auto-remove nzbget

		# Removing Services

		sudo systemctl stop nzbget.service
		sudo systemctl disable nzbget.service
		sudo systemctl daemon-reload
		sudo rm /etc/systemd/system/nzbget.service

		TASKCOMPLETE
	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
