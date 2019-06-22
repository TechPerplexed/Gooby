#!/bin/bash

MENU="View Rclone Traffic"

source $CONFIGS/Docker/.env

RAW=$(rclone rc --user ${RCLONEUSERNAME} --pass ${RCLONEPASSWORD} core/stats)
JRAW=$(rclone rc --user ${RCLONEUSERNAME} --pass ${RCLONEPASSWORD} job/list)
SDATE=$(date -d "-$(echo ${RAW} | jq '.elapsedTime') seconds" '+%F %H:%M:%S')
GIG=$(echo ${RAW} | jq '.bytes /1024/1024/1024')
CHECK=$(echo ${RAW} | jq .checks)
DEL=$(echo ${RAW} | jq .deletes)
ERR=$(echo ${RAW} | jq .errors)
FT=$(echo ${RAW} | jq .transfers)

TRANSFERS=$(echo ${RAW} | jq .transferring | jq length)
SIZE=$(echo ${RAW} | jq '[.transferring[].size]' | jq 'add /1024/1024/1024')
SPEED=$(echo ${RAW} | jq '[.transferring[].speed]' | jq 'add /1024/1024')
FILES=$(echo ${RAW} | jq '[ .transferring[] | {name: .name, percent: .percentage} ]')
QSIZE=$(echo ${JRAW} | jq .jobids | jq length)

clear
echo "Fetching your settings..."

# Menu Options

QUIT(){
	exit
}

# Display menu

show_menus() {
	clear
	echo " ${LBLUE}"
	MENUSTART
	echo " ${LBLUE}Transfers Since Reboot/Cleanup${STD}"
	echo -----------------------------------------
	echo ' Startup Time      : '${SDATE}
	echo -n ' Data transferred  : '; printf "%'.2f" ${GIG} ; echo ' GB'
	echo -n ' Files transferred : '; printf "%'d\n" ${FT}
	echo -n ' Checks completed  : '; printf "%'d\n" ${CHECK}
	echo -n ' Deletes performed : '; printf "%'d\n" ${DEL}
	echo -n ' Errors occurred   : '; printf "%'d\n" ${ERR}
	echo
	echo " ${LBLUE}Transfers Real Time${STD}"
	echo -----------------------------------------
	echo -n ' Rclone Sync jobs  : '; printf "%'d\n" ${QSIZE}
	echo -n ' Files in motion   : '; printf "%'d\n" ${TRANSFERS}
	echo -n ' Size of files     : '; printf "%'.2f" ${SIZE}; echo ' GB'
	echo -n ' Current speed     : '; printf "%'.2f" ${SPEED}; echo ' MB/sec'
	echo
	echo ' Files transferring:' ; echo  ${FILES} | jq
	echo
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LBLUE}"
	MENUEND
}

# Read Choices

read_options(){
	local choice
	read -n 1 -s -r -p "Choose option: " choice
	case $choice in
		[Zz]) QUIT ;;
		*) echo "${LRED}Please select a valid option${STD}" && sleep 2
	esac
}

MENUFINALIZE
