#!/bin/bash

ls /opt/Tautulli > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 8181

		# Main script

		sudo rm -r /opt/Tautulli

		# Removing Services

		sudo systemctl stop tautulli.service
		sudo systemctl disable tautulli.service
		sudo rm /etc/systemd/system/tautulli.service
		sudo systemctl daemon-reload

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
