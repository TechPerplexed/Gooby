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

		cd /tmp

		clear

		echo "You currently have the $( cat $TCONFIGS/rclonev ) version of $TASK installed"
		echo ""

		read -n 1 -s -r -p "Stable ${YELLOW}(S)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "" choice

		case "$choice" in
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta; echo "Beta" > $TCONFIGS/rclonev ;;
			s|S ) curl https://rclone.org/install.sh | sudo bash; echo "Stable" > $TCONFIGS/rclonev ;;
			* ) echo "No changes made" ;;
		esac

		cd ~
		clear
		read -e -p "Make any changes to your config? ${YELLOW}(y/N)${STD}? " -i "" choice

		case "$choice" in 
			y|Y )	sudo rclone config
				echo
				read -r RCLONESERVICE < $HOME/.config/rclone/rclone.conf; RCLONESERVICE=${RCLONESERVICE:1:-1}
				read -e -p "Confirm that this is what you named your mount: " -i "$RCLONESERVICE"
				echo
				read -e -p "What is your media folder in $RCLONESERVICE? (leave empty for root): " -i "" RCLONEFOLDER
				echo
				RCLONESERVICE=${RCLONESERVICE#:}; echo $RCLONESERVICE > $CONFIGS/.config/rcloneservice
				RCLONEFOLDER=${RCLONEFOLDER%/}; RCLONEFOLDER=${RCLONEFOLDER#/}; echo $RCLONEFOLDER > $CONFIGS/.config/rclonefolder
				source /opt/Gooby/install/misc/environment-build.sh rebuild
				;;
			* )	echo "All done!" ;;
		esac

		cd $CURDIR

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
