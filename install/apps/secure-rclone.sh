#!/bin/bash

which rclone > $CONFIGS/.config/checkapp
clear

if [ ! -s $CONFIGS/.config/checkapp ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		echo " $TASK does not have its own web page"
		echo " There is nothing to secure!"

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp
PAUSE
