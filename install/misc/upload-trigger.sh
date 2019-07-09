#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	echo
	echo "${GREEN}This will manually trigger your uploads."
	echo "This process runs every 15 minutes regardless!${STD}"
	echo

	source /opt/Gooby/scripts/cron/syncmount.sh

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
