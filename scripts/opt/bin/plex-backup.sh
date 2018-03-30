#!/bin/bash

# Stopping services
sudo systemctl stop tautulli.service
sudo service plexmediaserver stop

# Creating backup
sudo tar -cf /tmp/$(hostname).$(date +%F).tar.gz \
  /opt/Tautulli/config.ini \
  /opt/Tautulli/tautulli.db \
  /var/lib/plexmediaserver

# Starting services
sudo service plexmediaserver start
sudo systemctl start tautulli.service

# Copying to Gdrive
sudo rclone copy /tmp/$(hostname).* Gdrive:/Backup -v --checksum --drive-chunk-size=64M
sudo rm /tmp/$(hostname).*
echo -e "Done!"
