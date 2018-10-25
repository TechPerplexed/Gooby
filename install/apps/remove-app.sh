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
		sudo rm $CONFIGS/Docker/components/$APPLOC*
		/usr/local/bin/docker-compose down
		echo "Just a moment while $APP is being uninstalled..."
		source /opt/Gooby/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		cd "${CURDIR}"
		
		clear

		echo "$TASK has been removed".

		CONFIRMDELETE

		case "$REPLY" in
			y|Y ) [[ -d "$CONFIGS/$TASK" ]] && sudo rm -r $CONFIGS/$TASK ;;
			* ) echo "User settings not deleted" ;;
		esac

		sudo chown -R $USER:$USER $CONFIGS
		sudo chown -R $USER:$USER $TCONFIGS

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
