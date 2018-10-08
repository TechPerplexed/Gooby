#!/bin/bash

ls /opt/sonarr > /tmp/checkapp.txt; 
ls /opt/nzbdrone >> /tmp/checkapp.txt

clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		sudo apt-get purge --auto-remove sonarr -y

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
