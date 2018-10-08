#!/bin/bash

ls /var/lib/emby > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Dependencies

		RUNPATCHES

		# Open ports

		sudo ufw allow 8096

		# Main script
		
		cd /tmp
		clear
		echo -e "Copy latest Ubuntu X64 version from ${YELLOW}https://emby.media/linux-server.html${STD}"
		echo -e "Remove link below and paste link to emby-server-deb_verson.amd64.deb"
		echo -e "Or you can press Enter to install ${CYAN}v3.5.3.0${STD}:"
		echo ""
		read -e -p "Link: " -i "https://github.com/MediaBrowser/Emby.Releases/releases/download/3.5.3.0/emby-server-deb_3.5.3.0_amd64.deb" emby
		wget $emby

		sudo dpkg -i emby-server-deb*
		sudo rm /tmp/emby-server-deb*
		cd ~

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
