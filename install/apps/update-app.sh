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
		RUNPATCHES

		docker stop $APP
		docker start $APP
		sudo chown -R $USER:$USER $CONFIGS
		sudo chown -R $USER:$USER $TCONFIGS

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
