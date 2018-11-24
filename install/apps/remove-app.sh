#!/bin/bash

docker ps -q -f name=$APP > $TCONFIGS/checkapp
clear

if [ ! -s $TCONFIGS/checkapp ]; then

	NOTINSTALLED

else

	EXPLAINAPP

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		cd $CONFIGS/Docker
		echo " Just a moment while $APP is being uninstalled..."
		docker stop $APP
		sudo rm $CONFIGS/Docker/components/$APPLOC*
		source /opt/Gooby/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans
		cd "${CURDIR}"
		
		clear

		echo " $TASK has been removed".

		CONFIRMDELETE

		case "$REPLY" in
			y|Y ) [[ -d "$CONFIGS/$TASK" ]] && sudo rm -r $CONFIGS/$TASK; echo " Done, all traces of $TASK are gone" ;;
			* ) echo " User settings for $TASK preserved" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
