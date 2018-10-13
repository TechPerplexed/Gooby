#!/bin/bash

MENU="Check Environment"

# Menu Options

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${CYAN}"
	MENUSTART
echo "test"
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
