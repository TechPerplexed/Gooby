#!/bin/bash

clear

EXPLAINTASK

echo " Update the password to access your VPS"

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD
    
		clear

		echo
		read -e -p "Change password for user $USER ${YELLOW}(U)${STD} or root ${YELLOW}(R)?${STD} " -i "" choice

		case "$choice" in
			u|U ) passwd ;;
			r|U ) sudo -s passwd ;;
			* ) echo "No passwords changed" ;;
		esac

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
