#!/bin/bash

clear

# Explanation

echo -e "--------------------------------------------------"
echo -e " This will ${PERFORM} $TASK}"
echo -e " You probably only need to run this once..."
echo -e "--------------------------------------------------"
echo ""

# Confirmation

read -p " Are you sure you want to ${PERFORM} ${TASK} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  echo ""
  echo -e "Coming soon!"

  # Task Completed

  echo -e "${LMAGENTA}"
  echo -e "--------------------------------------------------"
  echo -e " ${PERFORM} $TASK completed"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"

else

  echo ""
  echo -e "--------------------------------------------------"
  echo -e " You chose ${YELLOW}not${STD} to ${PERFORM} ${TASK}"
  echo -e "--------------------------------------------------"
  echo ""

fi

PAUSE
