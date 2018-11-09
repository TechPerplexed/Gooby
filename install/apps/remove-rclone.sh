#!/bin/bash

which rclone > $TCONFIGS/checkapp
clear

if [ ! -s $TCONFIGS/checkapp ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Main script

		sudo rm /usr/bin/rclone
		sudo rm /usr/local/share/man/man1/rclone.1

		# Removing Services

		if [ -e /etc/systemd/system/rclone.service ]; then
			sudo systemctl stop rclone.service
			sudo systemctl disable rclone.service
			sudo rm /etc/systemd/system/rclone.service
		fi

		if [ -e /etc/systemd/system/gooby.service ]; then
			sudo systemctl stop gooby.service gooby-rclone.service gooby-find.service mnt-google.mount
			sudo systemctl disable gooby.service gooby-rclone.service gooby-find.service mnt-google.mount
			sudo rm /etc/systemd/system/rclone* /etc/systemd/system/mnt-*
		fi

		sudo systemctl daemon-reload

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
