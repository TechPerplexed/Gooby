#!/bin/bash

FUNCTION="Manage Applications"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Sonarr
SONARR(){
  /opt/GooPlex/install/apps/sonarr.sh
}

# Radarr
RADARR(){
  /opt/GooPlex/install/apps/radarr.sh
}

# Deluge
DELUGE(){
  /opt/GooPlex/install/apps/deluge.sh
}

# Netdata
NETDATA(){
  /opt/GooPlex/install/apps/netdata.sh
}

# Organizr
ORGANIZR(){
  /opt/GooPlex/install/apps/organizr.sh
}

# Exit
QUIT(){
  exit
}

# ------------
# Display menu
# ------------

show_menus() {
  clear
  echo -e " ${LPURPLE}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " G O O P L E X - Visit techperplexed.ga "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e " ${STD}"
  echo -e " ${LPURPLE}A${STD} - Sonarr"
  echo -e " ${LPURPLE}B${STD} - Radarr"
  echo -e " ${LPURPLE}C${STD} - Deluge"
  echo -e " ${LPURPLE}D${STD} - Netdata"
  echo -e " ${LPURPLE}E${STD} - Organizr"
  echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
  echo -e " ${LPURPLE}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
}

# ------------
# Read Choices
# ------------

read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in      
      [Aa]) SONARR ;;
      [Bb]) RADARR ;;
      [Cc]) DELUGE ;;
      [Ff]) NETDATA ;;
      [Gg]) ORGANIZR ;;
      [Zz]) QUIT ;;
      *) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
    esac
}
 
# ----------
# Finalizing
# ----------

trap '' SIGINT SIGQUIT SIGTSTP

while true
do 
  show_menus
  read_options
done
