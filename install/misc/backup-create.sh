#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	echo "Current backup schedule:"

	if ! crontab -l | grep 'backup.sh'; then

		echo
		echo "You currently have no backup cron scheduled."
		echo
		read -n 1 -s -r -p " Would you like to schedule a weekly backup (y/N)? "
		echo

		if [[ ${REPLY} =~ ^[Yy]$ ]]; then

			crontab -l | grep 'backup.sh' || (crontab -l 2>/dev/null; echo "15 2 * * SUN /opt/Gooby/scripts/cron/backup.sh > /dev/null 2>&1") | crontab -
			echo
			echo " Backup scheduled to run at 02:15 every Sunday"
			echo " You can always change this by typing ${LYELLOW}crontab -e${STD}"

		else

			echo " No worries, you can always add a backup schedule later!"

		fi

	fi

	echo
	echo " The backup can take several hours"
	echo " Please don't exit the terminal until it's done!"
	echo

	source /opt/Gooby/scripts/cron/backup.sh

	clear
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " Done! The backup can be found in your"
	echo " Backup folder (on the Google drive)"
	echo "--------------------------------------------------"
	echo "${STD}"

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
