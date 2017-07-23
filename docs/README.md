# Rainbow's Script Closet
Random Stuff and Things. Mainly Scripts. Use them at your own risk.
(Also dicking around with GH Pages, so don't mind how this looks)

## License
All scripts are released under a 2-clause BSD license.
See LICENSE for more information.
They come with no warranty. It is not my fault if they accidentally all your everything.

## Repo info:

This repository is organized by folder, with various scripts and utils living inside.

### virtbox-zvol
* virtbox-zvol.sh - Creates a ZFS zvol, configures permissions, and then creates and registers a VirtualBox VMDK shim for the zvol.
					This allows you to use the zvol to back a disk for VirtualBox.

### cygwin  (Empty)

### docs
Documentation

* README.md (This Document)
* Some stuff to make GHPages work

### installers
Installers for other programs

* ScrivenerInstallBSD.sh - Halfway finished installer for Scrivener inside the Linux ABI Compat layer on FreeBSD

### legacypkgs
Some FreeBSD packages since removed from ports I still find useful

### linode
A bunch of various files for linode-ey things, mostly written during my employment there.

* Linodebackup.sh - Backups script for remote backups. Run it from Rescue Mode
* slackattack.sh - Turns Linode's Slackware 14.1 Default Install into a complete (sans X11 stuff) install
* linode-opennode.lst - .lst file from playing around with installing opennode.
* longviewnorpm.sh - installer for Longview by Linode for non-RPM-based OSes or Linux Distributions.
* ubootfixme.sh - Fixes a common issue with some older Linode Ubuntu installs where dpkg freaks out and leaves the system in an unbootable state.

### misc-system-utils
A collection of misc. utils

* fishroot.sh - alters the home folder dataset on ZFS so fish prints ~ instead of /usr/home/$username 

### pkgsrc
A collection of scripts written involving pkgsrc

* porter.sh - A wrapper for pkgsrc to allow simple updating of the ports tree and installed ports without having to memorize CVS flags
* cyg* - A bunch of crap I wrote to make pkgsrc work happily in cygwin more easily
* osx-pkgsrc-bootstrap.sh - A tool to bootstrap pkgsrc on OS X in an automated manner.