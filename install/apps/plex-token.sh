#!/bin/bash

clear
echo "${YELLOW}"
echo "--------------------------------------------------"
echo " It seems you are new to $TASK"
echo " In order to proceed, you will need to visit"
echo " https://www.${LYELLOW}plex.tv/claim${YELLOW}"
echo " And copy the token to clipboard"
echo "--------------------------------------------------"
echo "${STD}"
read -e -p " Paste token here: " PLEXCLAIM
echo ""
echo "$PLEXCLAIM" > $CONFIGS/.config/plexclaim

