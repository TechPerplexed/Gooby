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

		echo ""
		echo "Please choose what version you want to install:"
		echo ""
		echo "Plex regular without CloudFlare (A) - default"
		echo "Plex regular with CloudFlare (B)?
		echo "Plex Pass without CloudFlare (C)"
		echo "Plex Pass with CloudFlare (D)"
		echo ""
		echo "(When in doubt, choose A)"
		read -n 1 -s -r -p " ---> "
		
		case "$REPLY" in
			a|A ) echo "Regular installation without CloudFlare..." ;;
			b|B ) APPLOC=$APPLOC-cf; echo "Regular installation with CloudFlare..." ;;
			c|C ) APPLOC=$APPLOC-pp; echo "Plex Pass without CloudFlare..." ;;
			d|D ) APPLOC=$APPLOC-pp-cf; echo "Plas Pass with CloudFlare..." ;;
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

rm /tmp/checkapp.txt
PAUSE
