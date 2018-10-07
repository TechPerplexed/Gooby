#!/bin/bash

cd /opt/Ombi > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Dependencies

		sudo apt-get upgrade -y && sudo apt-get upgrade -y

		# Main script
		
		clear

		read -e -p "Switch to Stable ${YELLOW}(S)${STD} or Development installation ${YELLOW}(D)?${STD} " -i "" choice

		case "$choice" in 
			s|S ) echo "deb [arch=amd64,armhf] http://repo.ombi.turd.me/stable/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list" ;;
			d|D ) echo "deb [arch=amd64,armhf] http://repo.ombi.turd.me/develop/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list" ;;
			* ) echo "No changes made" ;;
		esac
		
		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
