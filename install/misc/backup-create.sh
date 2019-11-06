#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	if [ ! -d ${CONFIGVARS}/snapshots ]; then

		echo
		echo " It looks like this is the first time you are creating a backup."
		echo " Please make ${LYELLOW}sure${STD} that you restore an existing backup first!"
		echo
		read -n 1 -s -r -p " Do you wish to proceed with the backup now (y/N)? "
		echo

		if [[ ${REPLY} =~ ^[Yy]$ ]]; then

			echo " Ok, proceeding..."; echo

		else
			echo " Ok, script will quit now to allow you to restore your existing backup first."; PAUSE; exit

		fi
	fi

	echo " Current backup schedule:"

	if ! crontab -l | grep 'backup.sh'; then

		echo
		echo " You currently have no backup cron scheduled."
		echo
		read -n 1 -s -r -p " Would you like to schedule a weekly backup (y/N)? "
		echo

		if [[ ${REPLY} =~ ^[Yy]$ ]]; then

			crontab -l | grep 'backup.sh' || (crontab -l 2>/dev/null; echo "15 2 * * SUN /opt/Gooby/scripts/cron/backup.sh > /dev/null 2>&1") | crontab -
			crontab -l | grep 'resetbackup' || (crontab -l 2>/dev/null; echo "10 2 1 * * /bin/resetbackup > /dev/null 2>&1") | crontab -
			echo
			echo " Backup scheduled to run at 02:15 every Sunday."
			echo " The incremental backup will reset on the first of each month."
			echo
			echo " You can always change these settings by typing ${LYELLOW}crontab -e${STD}"
			sleep 10

		else

			echo " No worries, you can always add a backup schedule later!"; sleep 10

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
