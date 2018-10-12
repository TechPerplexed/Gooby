#!/bin/bash

clear
echo " ${CYAN}"
MENUSTART
echo " ${CYAN}These are your current settings:${STD}"
echo "You are currently logged in as ${CYAN}$USER${STD}"
echo " Your timezone is set to ${CYAN}$TIMEZONE${STD}"
[[ -s $CONFIGS/.config/setemail ]] && echo " Your email address is currently set to ${CYAN}$EMAIL${STD}" || echo " You have not set an email address yet."
[[ -s $CONFIGS/.config/seturl ]] && echo " Your URL is currently set to ${CYAN}$URL${STD}" || echo " You have not set an URL yet"
echo " Your VPS IP address is ${CYAN}$PUBLICIP${STD}"
echo ""
echo " You can change these settings under menu option A - Server settings"
MENUEND

PAUSE
