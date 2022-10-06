## Gooby is proud to announce:

# OmniStream

What is OmniStream? It's next iteration of Gooby - entirely rebuilt from the ground up. It has many exciting new features such as:

* Multi user support: everything is in the user home folder - including the mounts.
* Full support of Traefik, with all its advantages such as a single domain certificate if used in conjunction with CloudFlare - no more Let’s Encrypt bans.
* Omni can create and remove subdomains on the fly - you won't need to manually edit your A records.
* More customizations than ever, plus a vastly improved menu system - maintaining your media server couldn't be easier.
* Last but not least, OmniStream is 100% dockerized now, including Rclone and MergerFS - you will never be “waiting on mounts” again!

**WARNING:** OmniStream is still a work in progress. Although it is fully functional, it may still be a little rough around the edges. We welcome your feedback!

## How to upgrade?

**MAKE A BACKUP BEFORE YOU START!** Read the information on [OmniStream.cloud](https://omnistream.cloud) first. You can start the upgrade by typing `omni-upgrade`.

## What will change?

There are a few things that will change, mainly with your mount locations. We have made sure impact is minimal, so you won't have to rescan your Plex, Emby or Jellyfin libraries again. However you will have to make some changes within your catalogue apps (Radarr, Sonarr, etc) and downloaders (Torrent, Usenet apps). If you created any custom yaml files, those will not port over automatically. You will need to manually keep a copy and adapt them to work with Omni.

## Who are behind OmniStream?

The same two people (kelinger and TechPerplexed) that created Gooby will be maintaining OmniStream, so you can still expect the same level of support and care. [OmniStream has its own location on GitHub](https://github.com/kelinger/OmniStream). Once you are ready to upgrade, meet us over there for questions and suggestions.

## Is Gooby going away?

No, you can keep using Gooby indefinitely. We won't be actively maintaining it any longer, but you'll never be forced to upgrade. Gooby is here to stay!

If for some reason you still want to install Gooby from scratch, run this command:

`sudo wget https://bit.ly/GetGooby2 -O /tmp/install.sh && sudo bash /tmp/install.sh`

## Disclaimer:

This software is supplied "AS IS" without any warranties and support. You are solely responsible for determining whether Gooby is compatible with your equipment and other software installed on your system. Make sure you have a backup of all your important data!

## Donate:

Thank you SO MUCH for your generosity - we promise we'll will think of you when we sip that coffee!

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate/?hosted_button_id=VRNLSU6P65FNJ)
