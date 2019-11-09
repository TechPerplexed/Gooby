#!/bin/bash

MENU="Installed Apps"

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
	docker ps -a --format "table {{.Status}}\t: ${COLOUR}{{.Names}}${STD}" | sort
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
