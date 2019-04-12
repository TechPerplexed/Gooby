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

		# Install MergerFS

		which mergerfs > $TCONFIGS/mergerfs
		if [ ! -s $TCONFIGS/mergerfs ]; then
			sudo wget https://github.com/trapexit/mergerfs/releases/download/2.24.2/mergerfs_2.24.2.ubuntu-xenial_amd64.deb -O /tmp/mergerfs.deb
			sudo dpkg -i /tmp/mergerfs.deb
		fi
		rm /$TCONFIGS/mergerfs

		# Main script

		cd /tmp
		clear
		read -n 1 -s -r -p "Stable ${YELLOW}(S)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "S" choice

		case "$choice" in 
			b|B ) curl https://rclone.org/install.sh | sudo bash -s beta; echo "Beta" > $TCONFIGS/rclonev ;;
			* ) curl https://rclone.org/install.sh | sudo bash; echo "Stable" > $TCONFIGS/rclonev ;;
		esac

		clear

		echo "${YELLOW}Please follow the instructions to setup Rclone${STD}"
		echo
		rclone config
		echo
		read -r RCLONESERVICE < $HOME/.config/rclone/rclone.conf; RCLONESERVICE=${RCLONESERVICE:1:-1}
		read -e -p "Confirm that this is what you named your mount  " -i "$RCLONESERVICE"
		echo
		echo "What is your media folder in $RCLONESERVICE?"
		read -e -p "Leave empty for root - not recommended! (ex: Media)  " -i "" RCLONEFOLDER
		echo

		cat $HOME/.config/rclone/rclone.conf | grep "[Local]" > /dev/null
		if ! [[ ${?} -eq 0 ]]; then
			echo [Local] >> $HOME/.config/rclone/rclone.conf
			echo type = local >> $HOME/.config/rclone/rclone.conf
			echo nounc = >> $HOME/.config/rclone/rclone.conf
		fi

		# Installing Services

		RCLONESERVICE=${RCLONESERVICE#:}; echo $RCLONESERVICE > $CONFIGS/.config/rcloneservice
		RCLONEFOLDER=${RCLONEFOLDER%/}; RCLONEFOLDER=${RCLONEFOLDER#/}; echo $RCLONEFOLDER > $CONFIGS/.config/rclonefolder

		sudo sed -i 's/^#user_allow_other/user_allow_other/g' /etc/fuse.conf

		source /opt/Gooby/install/misc/environment-build.sh rebuild

		mkdir -p $HOME/logs $HOME/Downloads
		sudo mkdir -p ${RCLONEMOUNT} ${MOUNTTO} ${UPLOADS} ${UNSYNCED}
		sudo chown -R $USER:$USER $HOME $CONFIGS/.config $TCONFIGS ${RCLONEMOUNT} ${MOUNTTO} ${UPLOADS} ${UNSYNCED}

		if [ ! -d ${UPLOADS}/Downloads ]; then
			sudo mv $HOME/Downloads ${UPLOADS}
			sudo ln -s ${UPLOADS}/Downloads $HOME/Downloads
		fi

		sudo rsync -a /opt/Gooby/scripts/services/rclonefs* /etc/systemd/system/
		sudo rsync -a /opt/Gooby/scripts/services/mergerfs* /etc/systemd/system/
		sudo sed -i "s/GOOBYUSER/${USER}/g" /etc/systemd/system/rclonefs.service
		sudo sed -i "s/GOOBYUSER/${USER}/g" /etc/systemd/system/mergerfs.service

		sudo systemctl enable rclonefs.service mergerfs.service
		sudo systemctl daemon-reload
		sudo systemctl start rclonefs.service
		sleep 10; sudo systemctl start mergerfs.service

		# Create syncmount cron
		crontab -l | grep 'syncmount.sh' || (crontab -l 2>/dev/null; echo "0,15,30,45 * * * * /opt/Gooby/scripts/cron/syncmount.sh > /dev/null 2>&1") | crontab -

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
