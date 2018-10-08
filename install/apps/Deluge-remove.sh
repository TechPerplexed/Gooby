#!/bin/bash

which deluged > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		sudo ufw delete allow 8112

		# Main script

		sudo apt-get -y purge --auto-remove \
			deluged \
			deluge-webui \
			deluge-console

		# Removing Services

		sudo systemctl stop deluged.service
		sudo systemctl stop deluge-web.service

		sudo systemctl disable deluged.service
		sudo systemctl disable deluge-web.service

		sudo rm /etc/systemd/system/deluged.service
		sudo rm /etc/systemd/system/deluge-web.service

		sudo systemctl daemon-reload

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
