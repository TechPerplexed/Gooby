#!/bin/bash

docker ps -q -f name=$APP > $CONFIGS/.config/checkapp.txt
clear

if [ ! -s $CONFIGS/.config/checkapp.txt ]; then

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

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt
PAUSE
