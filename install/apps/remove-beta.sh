#!/bin/bash

docker ps -q -f name=$APP > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINAPP

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		cd $CONFIGS/Docker
		sudo rm $CONFIGS/Docker/components/$APPLOC*
		/usr/local/bin/docker-compose down
		echo "Just a moment while $APP is being uninstalled..."
		source /opt/GooPlex/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		cd "${CURDIR}"
		
		clear

		echo "$TASK has been removed".

		CONFIRMDELETE

		case "$REPLY" in
			y|Y ) sudo rm -r $CONFIGS/$TASK ;;
			* ) echo "User settings not deleted" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
