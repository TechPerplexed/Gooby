#!/bin/bash

which rclone > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMTASK

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Close ports

		#na

		# Main script

		sudo rm /usr/bin/rclone
		sudo rm /usr/local/share/man/man1/rclone.1

		# Removing Services

		sudo systemctl stop rclone.service
		sudo systemctl disable rclone.service
		sudo rm /etc/systemd/system/rclone.service
		sudo systemctl daemon-reload

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
