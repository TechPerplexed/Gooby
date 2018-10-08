#!/bin/bash

ls /opt/Radarr > /tmp/checkapp.txt;
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 7878

		# Main script

		sudo rm -r /opt/Radarr
  
		# Removing Services

		sudo systemctl stop radarr.service
		sudo systemctl disable radarr.service
		sudo systemctl daemon-reload
		sudo rm /etc/systemd/system/radarr.service

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
