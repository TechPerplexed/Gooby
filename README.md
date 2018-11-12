Proudly presenting:

# Gooby 2!

Create an infinite Plex or Emby media server with Google Drive on a VPS.

GooPlex is now Gooby, completely rewritten from scratch. It has full docker integration for all apps, NginX with reverse proxy and Letsencrypt, one click (automatic) backup, several additional apps.

Basic [information and instructions can be found on TechPerplexed](http://bit.ly/TechPerplexed "How to create an infinite media server using a VPS and Cloud service").

## Installation:

Run with this command:  
`sudo wget http://bit.ly/GetGooby -O /tmp/install.sh && sudo bash /tmp/install.sh`

## Supported apps:

One click installation of Rclone, Plex, Tautulli, Emby, Sonarr, Radarr, Deluge, NZBGet, Jackett, Netdata, Organizr, Ombi and Portainer.
Lidarr, SABnzbd and Radarr4k are available through self installation.

Make sure you check out the excellent [Wiki here on GitHub](https://github.com/TechPerplexed/Gooby/wiki "Gooby Wiki") that Gooby participant @deedeefink has put together!

## Disclaimer:

This software is supplied "AS IS" without any warranties and support. You are solely responsible for determining whether Gooby is compatible with your equipment and other software installed on your system.

## Known issues:

Because this is a complete overhaul of the previous version, it will only be partically backwards compatible. You can probably import your Plex, Emby, Radarr and Sonarr database but you will have to tweak them all individually. The media path is different from before, also you'll have to re-establish the link between the apps (in order for Sonarr/Radarr to be able to talk to Deluge, etc).

If you can't live with these changes, make sure you switch back to the legacy branch before updating your Gooby/GooPlex from the menu!

## Donate:

By popular request, at long last here is a donate button. Thank you SO MUCH for your generosity - I promise I will think of you when I sip that coffee!

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2YZQCA4GA2RSG)
