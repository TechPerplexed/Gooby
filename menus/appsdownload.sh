#!/bin/bash

MENU="Download Applications"
source /opt/GooPlex/menus/variables.sh

# Menu Options

SONARR(){
	TASK=Sonarr
	APP=sonarr
	APPTYPE=generic
	APPLOC=52-sonarr.yaml
	source /opt/GooPlex/menus/apps.sh
}

RADARR(){
	TASK=Radarr
	APP=radarr
	APPTYPE=generic
	APPLOC=50-radarr.yaml
	source /opt/GooPlex/menus/apps.sh
}

DELUGE(){
	TASK=Deluge
	APP=deluge
	APPTYPE=generic
	APPLOC=40-deluge.yaml
	source /opt/GooPlex/menus/apps.sh
}

NZBGET(){
	TASK=NZBGet
	APP=nzbget
	APPTYPE=generic
	APPLOC=
	source /opt/GooPlex/menus/apps.sh
}

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LPURPLE}"
	MENUSTART
	echo " ${LPURPLE}A${STD} - Sonarr"
	echo " ${LPURPLE}B${STD} - Radarr"
	echo " ${LPURPLE}C${STD} - Deluge"
	echo " ${LPURPLE}D${STD} - NZBGet"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LPURPLE}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) SONARR ;;
		[Bb]) RADARR ;;
		[Cc]) DELUGE ;;
		[Dd]) NZBGET ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
