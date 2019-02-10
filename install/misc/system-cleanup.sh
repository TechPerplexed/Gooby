#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	echo
	echo "${GREEN}Giving your system a nice little spring cleaning...${STD}"
	echo

	source /opt/Gooby/scripts/cron/rclean.sh

	clear

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
