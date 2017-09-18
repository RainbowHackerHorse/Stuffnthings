#!/bin/sh
# Script to download and install Linux Slack Client on FreeBSD

set -x
set -e

SlackVER=2.8.0-0.1.fc21
SlackRPM=slack-$SlackVER.x86_64.rpm
LinABI=linux-c6
LinProcLine="linprocfs   /compat/linux/proc	linprocfs	rw	0	0"
TMPfs="tmpfs    /compat/linux/dev/shm	tmpfs	rw,mode=1777	0	0"

# Set Up Dependencies
if ! pkg info "$LinABI"; then 
	pkg install -y "$LinABI"
	echo "$LinProcLine" >> /etc/fstab
	echo "$TMPfs" >> /etc/fstab
fi
if ! pkg info rpm4;
	then pkg install -y rpm4
fi
if ! pkg info ca_root_nss;
	then pkg install -y ca_root_nss
fi
if ! pkg info libXScrnSaver;
	then pkg install -y libXScrnSaver
fi
if ! pkg info libsecret;
	then pkg install -y libsecret
fi
if ! pkg info gconf2;
	then pkg install -y gconf2
fi
if ! pkg info gcc;
	then pkg install -y gcc
fi

if [ ! -d "$HOME"/Downloads ]; then
	mkdir "$HOME"/Downloads
fi
cd "$HOME"/Downloads
fetch "https://downloads.slack-edge.com/linux_releases/$SlackRPM"
cd /compat/linux
rpm2cpio < "$HOME"/Downloads/"$SlackRPM" | cpio -id || echo 'FAILED TO INSTALL SLACK in /compat/linux'
ln -s /compat/linux/usr/lib/slack/libCallsCore.so /compat/linux/usr/lib64/libCallsCore.so || echo "FAILED TO LINK libCallsCore.so"
ln -s /compat/linux/usr/lib/slack/libffmpeg.so /compat/linux/usr/lib64/libffmpeg.so || echo "FAILED TO LINK libffmpeg.so"
ln -s /compat/linux/usr/lib/slack/libCallsCore.so /compat/linux/usr/lib64/libnode.so || echo "FAILED TO LINK libnode.so"

echo 'Please make sure /compat/linux/usr/bin is in your $PATH'
