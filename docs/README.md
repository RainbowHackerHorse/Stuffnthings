# Rainbow's Script Closet
Random Stuff and Things. Mainly Scripts. Use them at your own risk.
(Also dicking around with GH Pages, so don't mind how this looks)

## License
All scripts are released under a 2-clause BSD license.
They come with no warranty. It is not my fault if they accidentally all your everything.

## Repo info:

### Actually Useful Scripts:

* virtbox-zvol.sh - Creates a ZFS zvol, configures permissions, and then creates and registers a VirtualBox VMDK shim for the zvol.
					This allows you to use the zvol to back a disk for VirtualBox.
* porter.sh - A wrapper for pkgsrc to allow simple updating of the ports tree and installed ports without having to memorize CVS flags


### Not so useful stuff:

* slackattack.sh - Turns Linode's Slackware 14.1 Default Install into a complete (sans X11 stuff) install

* fishroot.sh - alters the home folder dataset on ZFS so fish prints ~ instead of /usr/home/$username 

* Linodebackup.sh - Backups script for remote backups. Run it from Rescue Mode

* ScrivenerInstallBSD.sh - Halfway finished installer for Scrivener inside the Linux ABI Compat layer on FreeBSD

* cyg* - A bunch of crap I wrote to make pkgsrc work happily in cygwin more easily