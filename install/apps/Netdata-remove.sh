#!/bin/bash

docker ps -q -f name=netdata > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		docker container stop netdata
		docker container rm netdata

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
