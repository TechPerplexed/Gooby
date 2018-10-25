Proudly presenting:

# Gooby 2!

Create an infinite Plex or Emby media server with Google Drive on a VPS.

GooPlex is now Gooby, completely rewritten from scratch. Now with full docker integration for all apps, NginX with reverse proxy and Letsencrypt, one click (automatic) backup, several additional apps.

More [information and instructions can be found on TechPerplexed](http://bit.ly/TechPerplexed "How to create an infinite media server using a VPS and Cloud service").

## Installation

Run with this command:  
`sudo wget http://bit.ly/GetGooby -O /tmp/install.sh && sudo bash /tmp/install.sh`

## Supported apps:

One click installation of Rclone, Plex, Tautulli, Emby, Sonarr, Radarr, Deluge, NZBGet, Jackett, Netdata, Organizr and Ombi.

## Disclaimer:

This software is supplied "AS IS" without any warranties and support. You are solely responsible for determining whether Gooby is compatible with your equipment and other software installed on your system.

## Known issues:

Because this is a full overhaul of the previous version, it will not be fully backwards compatible. You can import your Plex, Emby, Radarr and Sonarr database but you will have to tweak them all individually. The media path is different from before, also you'll have to re-establish the link between the apps (such as Sonarr/Radarr and Deluge etc).

If you can't live with these changes, make sure you switch back to the legacy brand before updating your Gooby/GooPlex from the menu!
