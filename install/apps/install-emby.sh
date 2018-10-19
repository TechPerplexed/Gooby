#!/bin/bash

docker ps -q -f name=$APP > $CONFIGS/.config/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINAPP

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		echo ""
		echo "Are you going to use a CloudFlare Certificate (C)?"
		echo "Or do you want regular installataion (R)? (When in doubt, choose R)"
		read -n 1 -s -r -p " ---> "
		
		case "$REPLY" in
			c|C ) APPLOC=$APPLOC-cf; echo "CloudFlare installation..." ;;
			r|R ) echo "Regular installation..." ;;
			* ) echo "No choice made, will use regular installation..." ;;
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

rm $CONFIGS/.config/checkapp.txt
PAUSE
