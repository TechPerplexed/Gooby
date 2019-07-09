#!/bin/bash

MENU="Rclone Activity"

source /opt/Gooby/menus/variables.sh
source $CONFIGS/Docker/.env

while true; do

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

	echo " ${LBLUE}"
	MENUSTART
	echo " Transfers Since Reboot/Cleanup"
	echo -----------------------------------------
	echo -n " Startup Time      : ${LBLUE}"${SDATE}; echo "${STD}"
	echo -n " Data transferred  : ${LBLUE}"; printf "%'.2f" ${GIG}; echo " GB${STD}"
	echo -n " Files transferred : ${LBLUE}"; printf "%'d\n" ${FT}; echo -n "${STD}"
	echo -n " Checks completed  : ${LBLUE}"; printf "%'d\n" ${CHECK}; echo -n "${STD}"
	echo -n " Deletes performed : ${LBLUE}"; printf "%'d\n" ${DEL}; echo -n "${STD}"
	echo -n " Errors occurred   : ${LBLUE}"; printf "%'d\n" ${ERR}; echo -n "${STD}"
	echo
	echo " Transfers Real Time"
	echo -----------------------------------------
	echo -n " Rclone Sync jobs  : ${LBLUE}"; printf "%'d\n" ${QSIZE}; echo -n "${STD}"
	echo -n " Files in motion   : ${LBLUE}"; printf "%'d\n" ${TRANSFERS}; echo -n "${STD}"
	echo -n " Size of files     : ${LBLUE}"; printf "%'.2f" ${SIZE}; echo " GB${STD}"
	echo -n " Current speed     : ${LBLUE}"; printf "%'.2f" ${SPEED}; echo " MB/sec${STD}"
	echo
	echo " Files transferring:"; echo ${FILES} | jq
	echo
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${LBLUE}"
	MENUEND

	sleep 1

	read -t 0.25 -N 1 input
	if [[ $input = "z" ]] || [[ $input = "Z" ]]; then 
		echo 
		break
	fi

done
