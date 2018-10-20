#!/bin/bash

ls /opt/emby-server > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 8096

		# Main script

  		sudo service emby-server stop
		sudo apt-get purge --auto-remove emby-server -y
		sudo rm -r /opt/emby-server

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
