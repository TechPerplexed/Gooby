#!/bin/bash

docker ps -q -f name=$APP > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		docker stop $APP
		docker start $APP

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

sudo rm /tmp/checkapp.txt
PAUSE
