#!/bin/bash

source $CONFIGS/Docker/.env
which rclone > $TCONFIGS/checkapp
clear

if [ -s $TCONFIGS/checkapp ]; then

	ALREADYINSTALLED

	echo "Here is a list of the root folders in your mount:"
	echo
	ls -1 ${MOUNTTO}
	echo
	echo "If you're getting an error here, please"
	echo "check your Rclone config settings."
	echo "You may need to uninstall and try again!"

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD
		RUNPATCHES
		
		# Install MergerFS (for future use)

		lsb_release -r -s > /$CONFIGS/osversion
		VERSION=$( cat /$CONFIGS/osversion )

		if [ "$VERSION" = "18.04" ]; then
			sudo apt-get -y install mergerfs
		else
			sudo wget https://github.com/trapexit/mergerfs/releases/download/2.24.2/mergerfs_2.24.2.ubuntu-xenial_amd64.deb -O /tmp/mergerfs.deb
			sudo dpkg -i /tmp/mergerfs.deb
		fi

		rm /$CONFIGS/osversion

		# Main script

		sudo mkdir -p $TCONFIGS
		cd /tmp
		read -n 1 -s -r -p "Stable ${YELLOW}(S)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "S" choice

		case "$choice" in 
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta; echo "Beta" > $TCONFIGS/rclonev ;;
			* ) curl https://rclone.org/install.sh | sudo bash; echo "Stable" > $TCONFIGS/rclonev ;;
		esac

		clear

		echo "${YELLOW}Please follow the instructions to setup Rclone${STD}"
		echo
		sudo rclone config
		echo
		read -r RCLONESERVICE < $HOME/.config/rclone/rclone.conf; RCLONESERVICE=${RCLONESERVICE:1:-1}
		read -e -p "Confirm that this is what you named your mount: " -i "$RCLONESERVICE"
		echo
		read -e -p "What is your media folder in $RCLONESERVICE? (press Enter for root): " -i "" FOLDER
		echo

		# Installing Services

		RCLONESERVICE=${RCLONESERVICE#:}; echo $RCLONESERVICE > $CONFIGS/.config/rcloneservice
		RCLONEFOLDER=${RCLONEFOLDER%/}; RCLONEFOLDER=${RCLONEFOLDER#/}; echo $RCLONEFOLDER > $CONFIGS/.config/rclonefolder
		RCLONEMOUNT=/mnt/rclone; echo $RCLONEMOUNT > $CONFIGS/.config/rclonemount
		MOUNTTO=/mnt/google; echo $MOUNTTO > $CONFIGS/.config/mountto
		UPLOADS=/mnt/uploads; echo $UPLOADS > $CONFIGS/.config/uploads

		sed -i 's/^#user_allow_other/user_allow_other/g' /etc/fuse.conf

		sudo mkdir -p $HOME/logs
		sudo mkdir -p $HOME/Downloads
		sudo mkdir -p ${RCLONEMOUNT}
		sudo mkdir -p ${MOUNTTO}
		sudo mkdir -p ${UPLOADS}

		sudo rsync -a /opt/Gooby/scripts/rclonefs.service /etc/systemd/system/rclonefs.service
		sudo rsync -a /opt/Gooby/scripts/merger.service /etc/systemd/system/mergerfs.service

		sudo chown -R $USER:$USER $CONFIGS
		sudo chown -R $USER:$USER $TCONFIGS
		sudo chown -R $USER:$USER $HOME
		sudo chown -R $USER:$USER $RCLONEMOUNT
		sudo chown -R $USER:$USER $MOUNTTO
		sudo chown -R $USER:$USER $UPLOADS
		
		sudo systemctl enable mergerfs.service
		sudo systemctl enable rclonefs.service
		sudo systemctl daemon-reload
		sudo systemctl start mergerfs.service
		wait 10
		sudo systemctl start rclonefs.service

		if [ ! -f $TCONFIGS/cronsyncmount ]; then
			(crontab -l 2>/dev/null; echo "0,15,30,45 * * * * /opt/Gooby/scripts/cron/syncmount.sh > /dev/null 2>&1") | crontab -
			touch $TCONFIGS/cronsyncmount
		fi

		echo
		echo "Done!"
		echo

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
