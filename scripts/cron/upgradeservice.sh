#!/bin/bash

if [ ! -s $CONFIGS/.config/version ]; then

	echo "${LYELLOW}Upgrading to v2.0.0 ...${STD}"; echo; sleep 2

	# Update Proxy

	sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components

	if [ -d $CONFIGS/Security ]; then
		sudo mv $CONFIGS/Certs $CONFIGS/Docker
		sudo mv $CONFIGS/Docker/Certs $CONFIGS/Docker/certs
		sudo mv $CONFIGS/nginx $CONFIGS/Docker
		sudo mv $CONFIGS/Security $CONFIGS/Docker
		sudo mv $CONFIGS/Docker/Security $CONFIGS/Docker/security
	fi

	# Upgrade Rclone service 

	cat /etc/systemd/system/rclonefs.service | grep "pass" > /dev/null
	if ! [[ ${?} -eq 0 ]]; then
		sudo mv /etc/systemd/system/rclone* /tmp
		sudo rsync -a /opt/Gooby/scripts/services/rclonefs* /etc/systemd/system/
		sudo sed -i "s/GOOBYUSER/${USER}/g" /etc/systemd/system/rclonefs.service
	fi

	cat $HOME/.config/rclone/rclone.conf | grep "Local" > /dev/null
	if ! [[ ${?} -eq 0 ]]; then
		echo [Local] >> $HOME/.config/rclone/rclone.conf
		echo type = local >> $HOME/.config/rclone/rclone.conf
		echo nounc = >> $HOME/.config/rclone/rclone.conf
	fi

	sudo systemctl daemon-reload

elif [ $( cat $CONFIGS/.config/upgrade ) = "2.1.0" ]; then

	echo "${LYELLOW}Upgrading to v2.2.1 ...${STD}"; echo; sleep 2

	# Check if necessary apps are installed

	sudo apt-get update

	APPLIST="acl apt-transport-https ca-certificates curl fuse git gpg-agent grsync jq mergerfs nano pigz rsyncufw socat sqlite3 unzip wget"

	for i in $APPLIST; do
		echo Checking $i...
		sudo apt-get -y install $i
	done

	# Update Configs

	sudo mv /var/local/.Gooby/* $CONFIGS/.config
	sudo mv $CONFIGS/.config/rclonev $CONFIGS/.config/rcloneversion
	sudo mv $CONFIGS/.config/upgrade $CONFIGS/.config/version

else

	echo "${GREEN}Your system has already been upgraded... prodeeding${STD}"; echo

fi

echo 2.2.1 > $CONFIGS/.config/version
