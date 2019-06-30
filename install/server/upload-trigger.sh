#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	echo
	echo "${GREEN}This will manually trigger your upload process (runs every 15 minutes regardless)${STD}"
	echo

	Gooby/scripts/cron/syncmount.sh

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
