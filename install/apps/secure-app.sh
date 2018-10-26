#!/bin/bash

docker ps -q -f name=$APP > $TCONFIGS/checkapp
clear

if [ ! -s $TCONFIGS/checkapp ]; then

	NOTINSTALLED

else

	FILENAME=$APP.$MYDOMAIN
	cd $CONFIGS/Security

	# Menu Options

	NEWUSER(){
		clear
		read -p "Username to add: " USERNAME

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

		cd $CURDIR
		docker stop $APP
		docker start $APP

		TASKCOMPLETE

		rm $TCONFIGS/checkapp
		PAUSE
	}

	DELUSER(){
		echo
		read -p "Username to remove (line number): " LINE
		sed -i '${LINE}d'

		cd $CURDIR
		docker stop $APP
		docker start $APP

		TASKCOMPLETE

		rm $TCONFIGS/checkapp
		PAUSE
	}

	QUIT(){
		exit
	}

	# Display menu

	show_menus() {
		clear
		echo " ${CYAN}"
		MENUSTART

		if [ -f $FILENAME ]; then

			echo " Current users for $TASK:"
			echo " The string after the name is the hashed password"
			echo
			cat -s -n $FILENAME
			echo

		else

			echo "You haven't added any passwords to $TASK yet"

		fi

		echo " ${CYAN}A${STD} - Add user to ${TASK}"
		echo " ${CYAN}R${STD} - Remove user from ${TASK}"
		echo " ${WHITE}Z${STD} - EXIT to Main Menu"
		echo " ${CYAN}"
		MENUEND
	}

	# Read Choices

	read_options(){
		local choice
		read -n 1 -s -r -p "Choose option: " choice
		case $choice in
			[Aa]) NEWUSER ;;
			[Rr]) DELUSER ;;
			[Zz]) QUIT ;;
			*) echo "${LRED}Please select a valid option${STD}" && sleep 2
		esac
	}

	MENUFINALIZE

fi
