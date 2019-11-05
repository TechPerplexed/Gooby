#!/bin/bash

docker ps -q -f name=$APP > ${CONFIGVARS}/checkapp
clear

if [ ! -s ${CONFIGVARS}/checkapp ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		cd $CONFIGS/Docker
		/usr/local/bin/docker-compose pull
		/usr/local/bin/docker-compose up --remove-orphans --build -d $APP
		cd ${CURDIR}

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm ${CONFIGVARS}/checkapp
PAUSE
