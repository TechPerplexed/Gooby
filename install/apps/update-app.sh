#!/bin/bash

docker ps -q -f name=$APP > $TCONFIGS/checkapp
clear

if [ ! -s $TCONFIGS/checkapp ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		cd $CONFIGS/Docker
		/usr/local/bin/docker-compose up -d --no-deps --build plex $APP
		cd ${CURDIR}

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
