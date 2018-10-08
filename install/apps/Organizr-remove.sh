#!/bin/bash

docker ps -q -f name=organizr > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		docker container stop organizr
		docker container rm organizr

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
