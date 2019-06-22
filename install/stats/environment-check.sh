#!/bin/bash

MENU="Check Environment"

source $CONFIGS/Docker/.env

clear
echo "Fetching your settings..."

# Menu Options

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LBLUE}"
	MENUSTART
	echo -n " OS version: ${LBLUE}" ; lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om ; echo -n "${STD}" ; echo -n "${STD}"
	echo " Timezone: ${LBLUE}$( cat /etc/timezone )${STD}"
	echo " Your Domain: ${LBLUE}$MYDOMAIN${STD}"
	echo " Your Email Address: ${LBLUE}$MYEMAIL${STD}"
	echo " Your Server IP Address: ${LBLUE}$IP${STD}"
	echo " In app media location: ${LBLUE}/Media${STD}"
	echo " In app download location: ${LBLUE}/Media/Downloads${STD}"
	echo " Gooby version: ${LBLUE}$VERSION${STD}"
	echo
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LBLUE}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
