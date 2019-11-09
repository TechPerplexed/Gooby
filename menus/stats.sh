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

PLEXSTATS(){
	PERFORM="stats"
	TASK="plex"
	source /opt/Gooby/install/stats/${TASK}-${PERFORM}.sh
}

QUIT(){
	exit
}

# Display menu

COLOUR=${LBLUE}

show_menus() {
	MENUSTART
	echo " ${COLOUR}A${STD} - Check Environment"
	echo " ${COLOUR}B${STD} - Installed Apps (Containers)"
	echo " ${COLOUR}C${STD} - View Rclone Activity"
	echo " ${COLOUR}D${STD} - Plex Statistics"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Aa]) CHECKENV ;;
		[Bb]) CONTAINERS ;;
		[Cc]) VIEWTRAFFIC ;;
		[Dd]) PLEXSTATS ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
