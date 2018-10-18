#!/bin/bash

ls /opt/sonarr > /tmp/checkapp.txt; 
ls /opt/nzbdrone >> /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Dependencies

		sudo -s apt-get -y install \
			libcurl3 \
			libmono-cil-dev \
			mono-devel \
			mediainfo \
			sqlite3 \
			apt-transport-https \
		denyhosts at sudo software-properties-common
		
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
		echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
		sudo apt -y update

		# Open ports

		sudo ufw allow 8989

		# Main script

		sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2A9B4BF8
		sudo echo "deb https://dl.bintray.com/sonarr/phantom wheezy main" | sudo tee /etc/apt/sources.list.d/sonarr.list

		sudo apt-get -y update
		clear
		sudo apt-get -y install sonarr

		# sudo chown -R plexuser:plexuser /opt/sonarr

		# sudo rsync -a /opt/GooPlex/scripts/sonarr.service /etc/systemd/system/sonarr.service
		# sudo systemctl enable sonarr.service
		# sudo systemctl daemon-reload
		# sudo systemctl start sonarr.service
		
		# sudo chown -R plexuser:plexuser $HOME

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
