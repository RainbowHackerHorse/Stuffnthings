#!/bin/bash
set -e
export PS4='Line ${LINENO}: '
set -x
#
# Modified version of Pür Linux portsnag utility for Cygwin on Windows
# Conceptually based on portsnap, from FreeBSD. 
# No portsnap code is contained in portsnag.
# I'm not awesome enough to successfully rip off Best OS.
# This script relies on CVS to do the heavy lifting, rather than portsnap's
# inbuilt goodness.
# Make sure you install GCC or Clang, and CVS as part of your cygwin setup
#
# Copyright 2016 RainbowHackerHorse
# Portsnag originally written by Rainbow
# All rights reserved
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted providing that the following conditions 
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

usage() {
	cat <<EOF
usage: cygports (bootstrap/fetch/update)

Commands:
	bootstrap 	 -- Fetch and bootstrap pkgsrc
	fetch        -- Delete and fetch a new copy of the ports tree.
	update       -- Update ports tree to match current snapshot, replacing
                  files and directories which have changed.
EOF
	exit 0
}

PKGSRCBRANCH=pkgsrc-2015Q4
export PKGSRCBRANCH

# Parse the command line

if [[ ${1} == "bootstrap" ]];
	then
		if ls $HOME/bin | grep -q bmake;
			then 
			echo "Already bootstrapped baby! Did you mean cygports fetch or cygports update?"
			exit 1
		fi
	echo "Bootstrapping CygPorts (NetBSD Pkgsrc)"
	cd $HOME
	cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -r $PKGSRCBRANCH -P pkgsrc
	$HOME/pkgsrc/bootstrap/bootstrap --unprivileged
	echo "Ports Bootstrapped."
	echo "Go ahead! Try it out! Example: cd $HOME/pkgsrc/shells/fish && bmake install clean"
	echo "More information on Pkgsrc is available at http://www.pkgsrc.org/ "
elif [[ ${1} == "fetch" ]];
	then
	echo "Warning! This will REMOVE your current pkgsrc tree and fetch a BRAND NEW ONE. Cool? (y/n)"
	read -n 1 ch
	if [ "$ch" == "n" ] ; then
		echo "Exiting..."
		exit 1
	fi
	rm -rf $HOME/pkgsrc
	echo "Deleting and fetching latest CygPorts (NetBSD Pkgsrc)"
	cd $HOME
	cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -r $PKGSRCBRANCH -P pkgsrc
elif [[ ${1} == "update" ]];
	then
	echo "Updating CygPorts..."
	cd $HOME/pkgsrc && env CVS_RSH=ssh cvs up -dP
elif [[ ${1} == "" ]];
	then
	usage
fi
