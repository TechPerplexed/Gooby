#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	echo
	echo "Giving your system a nice little spring cleaning..."
	echo

	# Add rlean to bootup cron if not added yet

	if [ ! -f $TCONFIGS/cronboot ]; then

		(crontab -l 2>/dev/null; echo "@reboot /opt/Gooby/scripts/cron/rclean.sh > /dev/null 2>&1") | crontab -
		touch $TCONFIGS/cronboot

	fi

	source /opt/Gooby/scripts/cron/rclean.sh

	clear

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
