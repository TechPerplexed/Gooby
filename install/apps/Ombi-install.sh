#!/bin/bash

ls /opt/Ombi > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Open ports

		sudo ufw allow 5000

		# Main script

		read -e -p "Stable ${YELLOW}(S)${STD} or Development installation ${YELLOW}(D)?${STD} " -i "S" choice

		case "$choice" in 
			d|D ) echo "deb [arch=amd64,armhf] http://repo.ombi.turd.me/develop/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list" ;;
			* ) echo "deb [arch=amd64,armhf] http://repo.ombi.turd.me/stable/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list" ;;
		esac
		
		cd /tmp
		wget -qO - https://repo.ombi.turd.me/pubkey.txt | sudo apt-key add -
		sudo apt update -y && sudo apt install ombi -y
		sudo chown -R plexuser:plexuser /opt/Ombi

		# Installing Services

		sudo rsync -a /opt/GooPlex/scripts/ombi.service /etc/systemd/system/ombi.service
		sudo systemctl enable ombi.service
		sudo systemctl daemon-reload
		sudo systemctl start ombi.service

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
