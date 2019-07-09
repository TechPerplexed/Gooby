#!/bin/bash

MENU="Statistics"
source /opt/Gooby/menus/variables.sh

# Menu Options

CHECKENV(){
	PERFORM="check"
	TASK="environment"
	source /opt/Gooby/install/stats/${TASK}-${PERFORM}.sh
}

CONTAINERS(){
	PERFORM="installed"
	TASK="apps"
	source /opt/Gooby/install/stats/${TASK}-${PERFORM}.sh
}

VIEWTRAFFIC(){
	PERFORM="view"
	TASK="traffic"
	source /opt/Gooby/install/stats/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LBLUE}"
	MENUSTART
	echo " ${LBLUE}A${STD} - Check Environment"
	echo " ${LBLUE}B${STD} - Installed Apps (Containers)"
	echo " ${LBLUE}C${STD} - View Rclone Activity"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LBLUE}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) CHECKENV ;;
		[Bb]) CONTAINERS ;;
		[Cc]) VIEWTRAFFIC ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
