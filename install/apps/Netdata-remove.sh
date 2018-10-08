#!/bin/bash

which netdata > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		sudo systemctl stop netdata
		sudo systemctl disable netdata
		clear
		echo "Enter through each line!"
		cd /path/to/netdata.git
		sudo ./netdata-uninstaller.sh --force
		sudo rm /usr/sbin/netdata
		cd ~

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
