#!/bin/bash

docker ps -q -f name=netdata > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINAPP

	CONFIRMDELETE

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		cd $CONFIGS/Docker
		/usr/local/bin/docker-compose down
		sudo rm $CONFIGS/Docker/components/02-netdata*
		source /opt/GooPlex/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		cd "${CURDIR}

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
