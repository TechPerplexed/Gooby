#!/bin/bash

MENU="These are your current parameters"

clear
echo " ${CYAN}"
MENUSTART
echo " You are currently logged in as ${CYAN}$USER${STD}"
echo " Your timezone is set to ${CYAN}$TIMEZONE${STD}"
[[ -s $CONFIGS/.config/setemail ]] && echo " Your email address is currently set to ${CYAN}$EMAIL${STD}" || echo " You have not set an email address yet."
[[ -s $CONFIGS/.config/seturl ]] && echo " Your URL is currently set to ${CYAN}$URL${STD}" || echo " You have not set an URL yet"
echo " Your VPS IP address is ${CYAN}$PUBLICIP${STD}"
echo ""
echo " You can change these settings in the main menu"
echo " Option A - Server settings"
MENUEND

PAUSE
