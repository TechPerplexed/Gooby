#!/bin/bash

docker ps -a -f "name=netdata" > /tmp/checkapp.txt
clear

if ! read -r && read -r; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Main script

		docker container stop netdata
		docker container start netdata

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi < /tmp/checkapp.txt

rm /tmp/checkapp.txt
PAUSE
