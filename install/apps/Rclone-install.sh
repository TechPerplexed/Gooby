#!/bin/bash

which rclone > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

	ALREADYINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Main script

		cd /tmp
		
		clear

		read -e -p "Release ${YELLOW}(R)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "R" choice

		case "$choice" in 
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
			* ) curl https://rclone.org/install.sh | sudo bash ;;
		esac

		cd ~
		clear

		echo "${YELLOW}Please follow the instructions to setup Rclone${STD}"
		echo ""
		sudo rclone config

		# Installing Services

		sudo mkdir -p /var/local/GooPlex
		sudo rsync -a $HOME/.config/rclone/rclone.conf $CONFIGS/.config
		sudo rsync -a /opt/GooPlex/scripts/rclone.service /etc/systemd/system/rclone.service
		sudo systemctl enable rclone.service
		sudo systemctl daemon-reload
		sudo systemctl start rclone.service
		sudo chown -R $USER:$USER $CONFIGS/.config

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
