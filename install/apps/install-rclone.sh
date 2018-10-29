#!/bin/bash

which rclone > $TCONFIGS/checkapp
clear

if [ -s $TCONFIGS/checkapp ]; then

	ALREADYINSTALLED

	echo
	echo " Here is a list of the root folders in /media/Google:"
	echo
	ls -1 /media/Google
	echo
	echo " If you're getting an error here, please check your"
	echo " Rclone config settings."
	echo " You may need to uninstall and try again!"
	echo

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES

		# Install MergerFS (for future use)

		lsb_release -r -s > /tmp/version
		VERSION=$( cat /tmp/version )

		if [ "$VERSION" = "18.04" ]; then sudo apt-get -y install mergerfs; fi

		rm /tmp/version

		# Main script

		cd /tmp
		sudo mkdir $TCONFIGS
		
		clear

		read -e -p "Stable ${YELLOW}(S)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "S" choice

		case "$choice" in 
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta; echo "Beta" > $TCONFIGS/rclonev ;;
			* ) curl https://rclone.org/install.sh | sudo bash; echo "Stable" > $TCONFIGS/rclonev ;;
		esac

		clear

		echo "${YELLOW}Please follow the instructions to setup Rclone${STD}"
		echo "Make sure you name the config ${YELLOW}Gdrive${STD}"
		echo
		sudo rclone config

		# Installing Services

		sudo mkdir -p /var/local/Gooby/.config
		sudo mkdir -p /var/local/.
		sudo mkdir -p $HOME/logs
		sudo mkdir -p $HOME/Downloads
		sudo mkdir -p /media/Google

		sudo rsync -a $HOME/.config/rclone/rclone.conf $CONFIGS/.config
		sudo rsync -a /opt/Gooby/scripts/rclone.service /etc/systemd/system/rclone.service

		sudo chown -R $USER:$USER $CONFIGS
		sudo chown -R $USER:$USER $TCONFIGS
		sudo chown -R $USER:$USER $HOME
		sudo chown -R $USER:$USER /media/Google

		sudo systemctl enable rclone.service
		sudo systemctl daemon-reload
		sudo systemctl start rclone.service

		echo
		echo "Done! Your mount can be found at ${YELLOW}/media/Google${STD}"

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
