#!/bin/bash

which rclone > $CONFIGS/.config/checkapp.txt
clear

if [ ! -s $CONFIGS/.config/checkapp.txt ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		RUNPATCHES

		cd /tmp

		read -e -p "Release ${YELLOW}(R)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "" choice

		case "$choice" in
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
			r|R ) curl https://rclone.org/install.sh | sudo bash ;;
			* ) echo "No changes made" ;;
		esac

		cd ~
		
		read -e -p "Make any changes to your config? ${YELLOW}(y/N)${STD}? " -i "" choice
		
		case "$choice" in 
			y|Y ) sudo rclone config; sudo rsync -a $HOME/.config/rclone/rclone.conf $CONFIGS/.config ;;
			* ) echo "All done!" ;;
		esac

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt
PAUSE
