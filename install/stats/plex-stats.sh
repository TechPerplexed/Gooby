#!/bin/bash

MENU="Plex Statistics"

source ${CONFIGS}/Docker/.env

clear
echo "Fetching your settings..."

# Menu Options

QUIT(){
	exit
}

# Display menu

COLOUR=${LBLUE}

show_menus() {
	MENUSTART
	source /opt/Gooby/scripts/bin/plexstats
	echo
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
