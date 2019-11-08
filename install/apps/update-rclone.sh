#!/bin/bash

which rclone > ${CONFIGVARS}/checkapp
clear

if [ ! -s ${CONFIGVARS}/checkapp ]; then

	NOTINSTALLED

else

	EXPLAINTASK

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		cd /tmp
		clear

		echo "You currently have the $( cat ${CONFIGVARS}/rcloneverson ) version of ${TASK} installed"
		echo ""

		read -n 1 -s -r -p "Stable ${YELLOW}(S)${STD} or Beta installation ${YELLOW}(B)?${STD} " -i "" CHOICE

		case "${CHOICE}" in
			b|B )	curl https://rclone.org/install.sh | sudo bash -s beta; echo "Beta" > ${CONFIGVARS}/rcloneversion ;;
			s|S )	curl https://rclone.org/install.sh | sudo bash; echo "Stable" > ${CONFIGVARS}/rcloneversion ;;
			* )	if [ $( cat ${CONFIGVARS}/rcloneversion ) = "Stable" ]; then
					curl https://rclone.org/install.sh | sudo bash
				elif [ $( cat ${CONFIGVARS}/rcloneversion ) = "Beta" ]; then
					curl https://rclone.org/install.sh | sudo bash -s beta
				fi ;;
		esac

		cd ~
		echo
		read -e -p "Make any changes to your config? ${YELLOW}(y/N)${STD}? " -i "" CHOICE

		case "${CHOICE}" in 
			y|Y )	sudo rclone config
				echo
				read -r RCLONESERVICE < ${HOME}/.config/rclone/rclone.conf; RCLONESERVICE=${RCLONESERVICE:1:-1}
				read -e -p "Confirm that this is what you named your mount: " -i "${RCLONESERVICE}"
				echo
				read -e -p "What is your media folder in ${RCLONESERVICE}? (leave empty for root): " -i "" RCLONEFOLDER
				echo
				RCLONESERVICE=${RCLONESERVICE#:}; echo ${RCLONESERVICE} > ${CONFIGVARS}/rcloneservice
				RCLONEFOLDER=${RCLONEFOLDER%/}; RCLONEFOLDER=${RCLONEFOLDER#/}; echo ${RCLONEFOLDER} > ${CONFIGVARS}/rclonefolder
				source /opt/Gooby/install/misc/environment-build.sh rebuild
				;;
			* )	echo "All done!" ;;
		esac

		sudo systemctl daemon-reload

		cd ${CURDIR}

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm ${CONFIGVARS}/checkapp
PAUSE
