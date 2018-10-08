#!/bin/bash

ls /opt/Ombi > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 5000

		# Main script

		sudo rm -r /opt/Ombi

		# Removing Services

		sudo systemctl stop ombi.service
		sudo systemctl disable ombi.service
		sudo systemctl daemon-reload
		sudo rm /etc/systemd/system/ombi.service

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
