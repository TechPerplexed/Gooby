#!/bin/bash

docker ps -q -f name=$APP > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINAPP

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		echo "Are you going to use a CloudFlare Certificate (y/N)?"
		echo "If in doubt, choose N!"
		read -n 1 -s -r -p " ---> "
		
		case "$REPLY" in
			y|Y ) APPLOC=$APPLOC-cf ;;
			* ) echo "" ;;
		esac

		cd $CONFIGS/Docker
		sudo rsync -a /opt/GooPlex/scripts/components/$APPLOC.yaml $CONFIGS/Docker/components
		/usr/local/bin/docker-compose down
		echo "Just a moment while $APP is being installed..."
		source /opt/GooPlex/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		sudo chown -R $USER:$USER $CONFIGS/$TASK
		cd "${CURDIR}"

		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
