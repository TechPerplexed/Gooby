#!/bin/bash

MENU="Rclone Activity"

source /opt/Gooby/menus/variables.sh
source ${CONFIGS}/Docker/.env
OPTION=${1}

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
	#QSIZE=$(echo ${JRAW} | jq .jobids | jq length)

	# Display menu

	COLOUR=${LBLUE}

	MENUSTART
	echo " Transfers Since Reboot/Cleanup"
	echo -----------------------------------------
	echo -n " Data transferred  : ${COLOUR}"; printf "%'.2f" ${GIG}; echo " GB${STD}"
	echo -n " Files transferred : ${COLOUR}"; printf "%'d\n" ${FT}; echo -n "${STD}"
	echo -n " Checks completed  : ${COLOUR}"; printf "%'d\n" ${CHECK}; echo -n "${STD}"
	echo -n " Deletes performed : ${COLOUR}"; printf "%'d\n" ${DEL}; echo -n "${STD}"
	echo -n " Errors occurred   : ${COLOUR}"; printf "%'d\n" ${ERR}; echo -n "${STD}"
	echo
	echo " Transfers Real Time"
	echo -----------------------------------------
	echo -n " Files in motion   : ${COLOUR}"; printf "%'d\n" ${TRANSFERS}; echo -n "${STD}"
	echo -n " Size of files     : ${COLOUR}"; printf "%'.2f" ${SIZE}; echo " GB${STD}"
	echo -n " Current speed     : ${COLOUR}"; printf "%'.2f" ${SPEED}; echo " MB/sec${STD}"
	echo

	if [[ ${OPTION,,} != "short" && ${TRANSFERS} != 0 ]]; then
		echo 'Files transferring:'
		echo
		for ((x=0; x<${TRANSFERS}; x++))
		do
			percent=$(echo ${RAW} | jq ".transferring[${x}] .percentage")
			name=$(echo ${RAW} | jq ".transferring[${x}] .name")
			name=$(basename "${name}")
			if [[ ${percent} -lt 10 ]]
			then
				percent=" ${percent}"
			fi
			echo  "${percent}% ${name//\"}" >> /tmp/xfer-${$}
		done
		cat /tmp/xfer-${$} | sort -n
		rm /tmp/xfer-${$}
	fi

	echo
	echo " ${WHITE}Z${STD} - EXIT to Main Menu"
	echo " ${COLOUR}"
	MENUEND

	sleep 1

	read -t 0.25 -N 1 input
	if [[ $input = "z" ]] || [[ $input = "Z" ]]; then 
		echo 
		break
	fi

done
