#!/bin/bash

ls /opt/sonarr > /tmp/checkapp.txt; 
ls /opt/nzbdrone >> /tmp/checkapp.txt
clear

if [ ! -s /tmp/checkapp.txt ]; then

	NOTINSTALLED

else

	NOAPPUPDATE

fi

rm /tmp/checkapp.txt
PAUSE
