# Check if necessary apps are installed

sudo apt-get update

APPLIST="acl apt-transport-https ca-certificates curl fail2ban fuse git gpg-agent grsync jq mergerfs nano rsyncufw socat unzip wget"

for i in $APPLIST; do
	echo Installing $i...
	echo
	sudo apt-get -y install $i
	echo; sleep 2
done

# Moving all Proxy folders to Docker

if [ -d $CONFIGS/Security ]; then
	sudo mv /$CONFIGS/Certs $CONFIGS/Docker
	sudo mv $CONFIGS/Docker/Certs $CONFIGS/Docker/certs
	sudo mv /$CONFIGS/nginx $CONFIGS/Docker
	sudo mv /$CONFIGS/Security $CONFIGS/Docker
	sudo mv $CONFIGS/Docker/Security $CONFIGS/Docker/security
fi

# Upgrade Rclone service 

cat /etc/systemd/system/rclone.service | grep "RCLONEUSERNAME" > /dev/null
if ! [[ ${?} -eq 0 ]]; then
	sudo mv /etc/systemd/system/rclone* /tmp
	sudo rsync -a /opt/Gooby/scripts/services/rclonefs* /etc/systemd/system/
	sudo sed -i "s/GOOBYUSER/${USER}/g" /etc/systemd/system/rclonefs.service
fi

cat $HOME/.config/rclone/rclone.conf | grep "[Local]" > /dev/null
if ! [[ ${?} -eq 0 ]]; then
	echo [Local] >> $HOME/.config/rclone/rclone.conf
	echo type = local >> $HOME/.config/rclone/rclone.conf
	echo nounc = >> $HOME/.config/rclone/rclone.conf
fi

# Upgrade Rclone service 

cat /etc/systemd/system/rclone.service | grep "RCLONEUSERNAME" > /dev/null
if ! [[ ${?} -eq 0 ]]; then
	sudo mv /etc/systemd/system/rclone* /tmp
	sudo rsync -a /opt/Gooby/scripts/services/rclonefs* /etc/systemd/system/
	sudo sed -i "s/GOOBYUSER/${USER}/g" /etc/systemd/system/rclonefs.service
fi

cat $HOME/.config/rclone/rclone.conf | grep "[Local]" > /dev/null
if ! [[ ${?} -eq 0 ]]; then
	echo [Local] >> $HOME/.config/rclone/rclone.conf
	echo type = local >> $HOME/.config/rclone/rclone.conf
	echo nounc = >> $HOME/.config/rclone/rclone.conf
fi

sudo systemctl daemon-reload

