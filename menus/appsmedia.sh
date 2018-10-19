#!/bin/bash

MENU="Media Applications"
source /opt/GooPlex/menus/variables.sh

# Menu Options

RCLONE(){
	TASK=Rclone
	APP=rclone
	APPTYPE=rclone
	source /opt/GooPlex/menus/apps.sh
}

PLEX(){
	TASK=Plex
	APP=plex
	APPTYPE=plex
	APPLOC=20-plex
	source /opt/GooPlex/menus/apps.sh
}

TAUTULLI(){
	TASK=Tautulli
	APP=tautulli
	APPTYPE=generic
	APPLOC=25-tautulli
	source /opt/GooPlex/menus/apps.sh
}

EMBY(){
	TASK=Emby
	APP=emby
	APPTYPE=emby
	APPLOC=22-emby
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
	echo " ${LPURPLE}A${STD} - Rclone"
	echo " ${LPURPLE}B${STD} - Plex"
	echo " ${LPURPLE}C${STD} - Tautulli"
	echo " ${LPURPLE}D${STD} - Emby"
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LPURPLE}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Aa]) RCLONE ;;
		[Bb]) PLEX ;;
		[Cc]) TAUTULLI ;;
		[Dd]) EMBY ;;      
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
