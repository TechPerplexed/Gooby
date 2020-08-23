#!/bin/bash

MENU="Download Applications"
source /opt/Gooby/menus/variables.sh

# Menu Options

RADARR(){
	TASK=Radarr
	APP=radarr
	APPTYPE=app
	APPLOC=51-radarr
	OLDLOC=${USER}/.config/Radarr/
	source /opt/Gooby/menus/apps.sh
}

SONARR(){
	TASK=Sonarr
	APP=sonarr
	APPTYPE=app
	APPLOC=52-sonarr
	OLDLOC=${USER}/.config/NzbDrone/
	source /opt/Gooby/menus/apps.sh
}

DELUGE(){
	TASK=Deluge
	APP=deluge
	APPTYPE=app
	APPLOC=41-deluge
	OLDLOC=${USER}/.config/deluge/
	source /opt/Gooby/menus/apps.sh
}

NZBGET(){
	TASK=NZBGet
	APP=nzbget
	APPTYPE=app
	APPLOC=31-nzbget
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

JACKETT(){
	TASK=Jackett
	APP=jackett
	APPTYPE=app
	APPLOC=56-jackett
	OLDLOC=/noupgradepathprovided
	source /opt/Gooby/menus/apps.sh
}

QUIT(){
	exit
}

# Display menu

COLOUR=${LPURPLE}

show_menus() {
	MENUSTART
	echo " ${COLOUR}A${STD} - Radarr"
	echo " ${COLOUR}B${STD} - Sonarr"
	echo " ${COLOUR}C${STD} - Deluge"
	echo " ${COLOUR}D${STD} - NZBGet"
	echo " ${COLOUR}E${STD} - Jackett"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND
}

# Read Choices

read_options(){
	local CHOICE
	read -n 1 -s -r -p "Choose option: " CHOICE
	case ${CHOICE} in
		[Aa]) RADARR ;;
		[Bb]) SONARR ;;
		[Cc]) DELUGE ;;
		[Dd]) NZBGET ;;
		[Ee]) JACKETT ;;
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 1
	esac
}

MENUFINALIZE
