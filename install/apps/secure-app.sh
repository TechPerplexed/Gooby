#!/bin/bash

docker ps -q -f name=$APP > $TCONFIGS/checkapp
clear

if [ ! -s $TCONFIGS/checkapp ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		FILENAME=$APP.$MYDOMAIN
		cd $CONFIGS/Security

		if [ -f $FILENAME ]; then

			echo " Current users for $TASK:"
			echo
			cat -s -n $FILENAME

			# Remove user
			echo " Removing users coming soon..."
			echo

	else

		echo "You haven't added any passwords to $TASK yet"

	fi

	# Add user

		echo
		read -p "Name: " USERNAME

	try_install() {
		dpkg -l "$1" | grep -q ^ii && return 1		# Package already installed
		echo
		echo Installing ${@}
		echo
		sudo apt -y install "$@"
		return 0
	}

		# Check to see if apache2-utils are installed.  If not, then install them.

		try_install apache2-utils

		echo

		if [[ -e ${FILENAME} ]]
		then							# File exists so append with new user
			echo Updating file ${FILENAME}
			echo Adding  user ${USERNAME}
			htpasswd ${FILENAME} ${USERNAME}
		else							# Create file then create first user
			echo Creating file ${FILENAME}
			echo Adding user ${USERNAME}
			htpasswd -c ${FILENAME} ${USERNAME}
		fi

		docker stop $APP
		docker start $APP

		cd $CURDIR

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $TCONFIGS/checkapp
PAUSE
