#!/bin/bash

MENU="Check Environment"

source ${CONFIGS}/Docker/.env

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
	echo -n " OS Version        : ${LBLUE}" ; lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om ; echo -n "${STD}" ; echo -n "${STD}"
	echo " Server Name       : ${LBLUE}${SERVER}${STD}"
	echo " Timezone          : ${LBLUE}${TIMEZONE}${STD}"
	echo " Domain            : ${LBLUE}${MYDOMAIN}${STD}"
	echo " Email Address     : ${LBLUE}${MYEMAIL}${STD}"
	echo " IP Address        : ${LBLUE}${IP}${STD}"
	echo " Proxy Version     : ${LBLUE}${PROXYVERSION^^}${STD}"
	echo " Gooby Version     : ${LBLUE}${VERSION}${STD}"
	echo
	echo " Media Location    : ${LBLUE}/Media${STD}"
	echo " Download Location : ${LBLUE}/Media/Downloads${STD}"
	echo
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LBLUE}"
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
