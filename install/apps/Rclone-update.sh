#!/bin/bash

which rclone > /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		# Dependencies

		RUNPATCHES

		# Main script

		cd /tmp

		read -e -p "Release ${YELLOW}(R)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "R" choice

		case "$choice" in
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
			r|R ) curl https://rclone.org/install.sh | sudo bash ;;
			* ) echo "No changes made" ;;
		esac

		cd ~

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm /tmp/checkapp.txt
PAUSE
