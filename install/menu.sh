#!/bin/bash
# Dooplex Menu

# --------------------------
# Step #1: Define variables
# --------------------------

STD='\033[0m'
RED='\033[00;31m'
GRN='\033[00;32m'
YLW='\033[00;33m'

# -------------------------------
# Step #2: User defined function
# -------------------------------

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

# Option 1
one(){
  bash bash /opt/Dooplex/install/apps/menu.sh ;;
  pause
}

# Option 2
two(){
  bash bash /opt/Dooplex/install/server/menu.sh ;;
  pause
}

# Option 3
three(){
  bash bash /opt/Dooplex/install/misc/menu.sh ;;
  pause
}

# Function to display menus
show_menus() {
	clear
	echo "-------------------------"	
	echo " D O O P L E X - M E N U"
	echo "-------------------------"
	echo ""
	echo -e "${GRN}1.${STD} Install and maintain Apps"
	echo -e "${GRN}2.${STD} Server maintenance"
	echo -e "${GRN}3.${STD} Additional options"
	echo -e "${YLW}4.${STD} Exit menu"
}

# Read input from the keyboard and take a action
read_options(){
	local choice
	read -p "Enter choice [ 1 - 4] " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) three ;;
		4) exit 0;;
		*) echo -e "${RED}Please select a valid option${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# ------------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
  show_menus
  read_options
done
