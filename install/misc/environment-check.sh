#!/bin/bash

MENU="Check Environment"

source $CONFIGS/Docker/.env
sudo chown -R $USER:$USER $CONFIGS

# Menu Options

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${CYAN}"
	MENUSTART
	echo " Timezone: ${CYAN}$TIMEZONE${STD}"
	echo " Your Domain: ${CYAN}$MYDOMAIN${STD}"
	echo " Your Email Address: ${CYAN}$MYEMAIL${STD}"
	echo " Your Server IP Address: ${CYAN}$IP${STD}"
	echo " GooPlex version: ${CYAN}$VERSION${STD}"
	echo ""
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${CYAN}"
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
