#!/bin/bash

VERSION="2-alpha"
CONFIGS=/var/local/Gooby
TCONFIGS=/var/local/.gtemp
CURDIR=$(pwd)

# Define colors

STD=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LGRAY=$(echo -en '\033[00;37m')
LRED=$(echo -en '\033[01;31m')
LGREEN=$(echo -en '\033[01;32m')
LYELLOW=$(echo -en '\033[01;33m')
LBLUE=$(echo -en '\033[01;34m')
LMAGENTA=$(echo -en '\033[01;35m')
LPURPLE=$(echo -en '\033[01;35m')
LCYAN=$(echo -en '\033[01;36m')
WHITE=$(echo -en '\033[01;37m')

# Define choices

RUNPATCHES(){
	sudo apt-get update
	sudo apt-get upgrade -y
	# sudo apt-get dist-upgrade -y
	# sudo apt autoremove -y
	# sudo apt autoclean
	# sudo apt-get autoremove
}

MENUSTART(){
	echo "--------------------------------------------------"
	echo " G O O B Y - Find instructions at techperplexed.ga"
	echo "--------------------------------------------------"
	echo " $MENU"
	echo " ${STD}"
}

MENUEND(){
	echo "--------------------------------------------------"
	echo " ${STD}"
}

MENUFINALIZE(){
	trap '' SIGINT SIGQUIT SIGTSTP
	while true
	do
	show_menus
	read_options
	done
}

MENUVISIT(){
	clear
	echo ""
	echo "--------------------------------------------------"
	echo " Visit the menu any time by typing '${WHITE}gooby${STD}'"
	echo "--------------------------------------------------"
	echo ""
}

ALREADYINSTALLED(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " ${TASK} appears to be installed"
	echo "--------------------------------------------------"
	echo "${STD}"
}

NOTINSTALLED(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " ${TASK} is not installed yet"
	echo "--------------------------------------------------"
	echo "${STD}"
}

APPINSTALLED(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " ${TASK} is now installed"
	echo " You can reach it through this URL:"
	echo " ${WHITE}$APP.$MYDOMAIN${YELLOW}"
	echo " Don't forget to create an A record with your"
	echo " Provider for ${WHITE}$APP${YELLOW} and point it to"
	echo " Your server IP address ${WHITE}$IP${YELLOW}"
	echo "--------------------------------------------------"
	echo "${STD}"
}

NOAPPUPDATE(){
	echo "${LRED}"
	echo "--------------------------------------------------"
	echo " ${TASK} cannot be updated through this menu"
	echo " You can update it from the web interface itself"
	echo "--------------------------------------------------"
	echo "${STD}"
}

EXPLAINTASK(){
	clear
	echo "${CYAN}"
	echo "--------------------------------------------------"
	echo " This will ${PERFORM} ${TASK}"
	echo "--------------------------------------------------"
	echo "${STD}"
}

EXPLAINAPP(){
	clear
	echo "${CYAN}"
	echo "--------------------------------------------------"
	echo " This will ${PERFORM} ${TASK}"
	echo " You will have a few seconds of server downtime"
	echo "--------------------------------------------------"
	echo "${STD}"
}

CONFIRMATION(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " Are you sure you want to ${PERFORM} ${TASK} (y/N)? "
	echo "--------------------------------------------------"
	echo "${STD}"
	read -n 1 -s -r -p " ---> "
	echo ""
}

CONFIRMDELETE(){
	echo "${LRED}"
	echo "--------------------------------------------------"
	echo " DANGER ZONE - EXTREME CAUTION!!!"
	echo " Do you want to delete all user settings as well?"
	echo " This cannot be undone"
	echo " Make sure you have a backup!"
	echo " Proceed? (y/N)?"
	echo "--------------------------------------------------"
	echo "${STD}"
	read -n 1 -s -r -p " ---> "
	echo ""
}

GOAHEAD(){
	clear
	echo "${LMAGENTA}"
	echo "--------------------------------------------------"
	echo " Starting ${PERFORM} ${TASK}"
	echo "--------------------------------------------------"
	echo "${STD}"
}

TASKCOMPLETE(){
	echo "${LMAGENTA}"
	echo "--------------------------------------------------"
	echo " ${PERFORM} ${TASK} completed"
	echo "--------------------------------------------------"
	echo "${STD}"
}

CANCELTHIS(){
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " Cancelling ${PERFORM} ${TASK}"
	echo "--------------------------------------------------"
	echo "${STD}"
}

PAUSE(){
	echo "${GREEN}"
	echo "--------------------------------------------------"
	echo " All done! Press Enter to return to the menu"
	echo "--------------------------------------------------"
	echo "${STD}"
	read -n 1 -s -r -p " ---> "
	echo ""
}
