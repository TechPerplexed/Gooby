#!/bin/bash

source ${CONFIGS}/Docker/.env
which rclone > ${CONFIGVARS}/checkapp.txt
clear

if [ ! -s ${CONFIGVARS}/checkapp.txt ]; then

	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " You will need to install and configure"
	echo " Rclone before you can run the system clean!"
	echo "--------------------------------------------------"
	echo "${STD}"

else

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

fi

rm ${CONFIGVARS}/checkapp.txt 2>/dev/null;

PAUSE
