#!/bin/bash

# Define colors

STD=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LIGHTGRAY=$(echo -en '\033[00;37m')
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
	clear
}

MENUSTART(){
	echo -e "--------------------------------------------------"
	echo -e " G O O P L E X - Visit techperplexed.ga"
	echo -e --------------------------------------------------"
	echo -e " $MENU"
	echo -e " ${STD}"
}

MENUEND(){
	echo -e "--------------------------------------------------"
	echo -e " ${STD}"
}

MENUVISIT(){
	clear
	echo ""
	echo "--------------------------------------------------"
	echo -e " Visit the menu any time by typing '${WHITE}gooplex${STD}'"
	echo "--------------------------------------------------"
	echo ""
}

ALREADYINSTALLED(){
	echo -e "${YELLOW}"
	echo -e "--------------------------------------------------"
	echo -e " ${TASK} appears to be installed"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
}

NOTINSTALLED(){
	echo -e "${YELLOW}"
	echo -e "--------------------------------------------------"
	echo -e " ${TASK} is not installed yet"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
}

NOAPPUPDATE(){
	echo -e "${LRED}"
	echo -e "--------------------------------------------------"
	echo -e " ${TASK} cannot be updated through this menu"
	echo -e " You can update it from the web interface itself"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
}

EXPLAINTASK(){
	echo -e "${CYAN}"
	echo -e "--------------------------------------------------"
	echo -e " This will ${PERFORM} ${TASK}"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
}

CONFIRMATION(){
	echo -e "${YELLOW}"
	echo -e "--------------------------------------------------"
	echo -e " Are you sure you want to ${PERFORM} ${TASK} (y/N)? "
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
	read -t 10 -n 1 -s -r -p " ---> "
	echo ""
}

CONFIRMDELETE(){
	echo -e "${LRED}"
	echo -e "--------------------------------------------------"
	echo -e " DANGER ZONE - EXTREME CAUTION!!!"
	echo -e " Are you really really sure?"
	echo -e " You are about to ${PERFORM} ${TASK}"
	echo -e " Including user settings and databases"
	echo -e " Make sure you have a backup first!"
	echo -e " Proceed? (y/N)?"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
	read -t 10 -n 1 -s -r -p " ---> "
	echo ""
}

GOAHEAD(){
	echo -e "${LMAGENTA}"
	echo -e "--------------------------------------------------"
	echo -e " Starting ${PERFORM} ${TASK}"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
}

TASKCOMPLETE(){
	echo -e "${LMAGENTA}"
	echo -e "--------------------------------------------------"
	echo -e " ${PERFORM} ${TASK} completed"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
}

CANCELTHIS(){
	echo -e "${YELLOW}"
	echo -e "--------------------------------------------------"
	echo -e " Cancelling ${PERFORM} ${TASK}"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
}

PAUSE(){
	echo -e "${GREEN}"
	echo -e "--------------------------------------------------"
	echo -e " All done! Press Enter to return to the menu"
	echo -e "--------------------------------------------------"
	echo -e "${STD}"
	read -t 10 -n 1 -s -r -p " ---> "
	echo ""
}
