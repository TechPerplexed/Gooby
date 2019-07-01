#!/bin/bash

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
  echo " Transfers Since Reboot/Cleanup"
  echo -----------------------------------------
  echo 'Startup Time      : '${SDATE}
  echo -n 'Data transferred  : '; printf "%'.2f" ${GIG} ; echo ' GB'
  echo -n 'Files transferred : '; printf "%'d\n" ${FT}
  echo -n 'Checks completed  : '; printf "%'d\n" ${CHECK}
  echo -n 'Deletes performed : '; printf "%'d\n" ${DEL}
  echo -n 'Errors occurred   : '; printf "%'d\n" ${ERR}
  echo 
  echo " Transfers Real Time"
  echo -----------------------------------------
  echo -n 'TurboSync jobs    : '; printf "%'d\n" ${QSIZE}
  echo -n 'Files in motion   : '; printf "%'d\n" ${TRANSFERS}
  echo -n 'Size of files     : '; printf "%'.2f" ${SIZE}; echo ' GB'
  echo -n 'Current speed     : '; printf "%'.2f" ${SPEED}; echo ' MB/sec'
  echo
  echo 'Files transferring:' ; echo  ${FILES} | jq
  echo
  echo " ${WHITE}Z${STD} - EXIT to Main Menu"
  echo " ${LBLUE}"
  sleep 1

  read -t 0.25 -N 1 input
  if [[ $input = "z" ]] || [[ $input = "Z" ]]; then 
    echo 
    break
  fi

done
