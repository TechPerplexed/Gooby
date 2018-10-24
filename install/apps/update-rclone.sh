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

		clear

		echo "You currently have the $( cat $TCONFIGS/rclonev ) version of $TASK installed"
		echo ""

		read -e -p "Stable ${YELLOW}(S)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "" choice

		case "$choice" in
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta; echo "Beta" > $TCONFIGS/rclonev ;;
			s|S ) curl https://rclone.org/install.sh | sudo bash; echo "Stable" > $TCONFIGS/rclonev ;;
			* ) echo "No changes made" ;;
		esac

		cd ~
		
		read -e -p "Make any changes to your config? ${YELLOW}(y/N)${STD}? " -i "" choice
		
		case "$choice" in 
			y|Y ) sudo rclone config; sudo rsync -a $HOME/.config/rclone/rclone.conf $CONFIGS/.config ;;
			* ) echo "All done!" ;;
		esac

		cd $CURDIR

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt
PAUSE
