#!/bin/bash

FUNCTION="Install/Update Applications"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Rclone
RCLONE(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Plex
PLEX(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Tautulli
TAUTULLI(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Sonarr
SONARR(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Radarr
RADARR(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Deluge
DELUGE(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Netdata
NETDATA(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Organizr
ORGANIZR(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Exit
QUIT(){
  clear
  echo ""
  echo "---------------------------------------------"
  echo " Visit the menu any time by typing 'gooplex' "
  echo "---------------------------------------------"
  echo ""
  exit
}

# ------------
# Display menu
# ------------

show_menus() {
  clear
  echo -e " ${GREEN}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
  echo -e " ${GRN}A${STD} - Rclone"
  echo -e " ${GRN}B${STD} - Plex"
  echo -e " ${GRN}C${STD} - Tautulli"
  echo -e " ${GRN}D${STD} - Sonarr"
  echo -e " ${GRN}E${STD} - Radarr"
  echo -e " ${GRN}F${STD} - Deluge"
  echo -e " ${GRN}G${STD} - Netdata"
  echo -e " ${GRN}H${STD} - Organizr"
  echo -e " ${YLW}Z${STD} - Exit $FUNCTION"
  echo -e ""
}

# ------------
# Read Choices
# ------------

read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      [Aa]) RCLONE ;;
      [Bb]) PLEX ;;
      [Cc]) TAUTULLI ;;
      [Dd]) SONARR ;;
      [Ee]) RADARR ;;
      [Ff]) DELUGE ;;
      [Gg]) NETDATA ;;
      [Hh]) ORGANIZR ;;
      [Zz]) QUIT ;;
      *) echo -e "${RED}Please select a valid option${STD}" && sleep 2
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
