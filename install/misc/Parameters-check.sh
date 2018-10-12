#!/bin/bash

clear

EXPLAINTASK

echo "These are your current settings:"
echo ""  
echo "You are currently logged in as $USERID"
echo ""
echo "Your timezone is set to $TIMEZONE"
echo ""
[[ -s $CONFIGS/.config/setemail ]] && echo "Your email address is currently set to $EMAIL" || echo "You have not set an email address yet."
echo ""
[[ -s $CONFIGS/.config/seturl ]] && echo "Your URL is currently set to $URL" || echo "You have not set an URL yet"
echo ""
echo "Your VPS IP address is $PUBLICIP"
echo ""
echo "You can change these settings under menu option A - Server settings"

PAUSE
