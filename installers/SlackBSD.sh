#!/bin/sh
# Script to download and install Linux Slack Client on FreeBSD

set -x
set -e

SlackVER=2.8.0-0.1.fc21
SlackRPM=slack-$SlackVER.x86_64.rpm
SlackMirror="https://downloads.slack-edge.com/linux_releases"
LinABI=linux-c7
LinVer=el7
LinProcLine="linprocfs   /compat/linux/proc	linprocfs	rw	0	0"
TMPfs="tmpfs    /compat/linux/dev/shm	tmpfs	rw,mode=1777	0	0"
LinMirror="http://mirror.centos.org/centos/7.4.1708/os/x86_64/Packages"
GConfVer="3.2.6-8.$LinVer.x86_64"
GConfRPM="GConf2-$GConfVer.rpm"
ORBitVer="2.14.19-13.$LinVer.x86_64"
ORBitRPM="ORBit2-$ORBitVer.rpm"

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
# Linking slack provided libs
echo "/usr/lib/slack" >> /compat/linux/etc/ld.so.conf

cd "$HOME"/Downloads
fetch "$LinMirror/$GConfRPM"
fetch "$LinMirror/$ORBitRPM"
fetch "$SlackMirror/$SlackRPM"

cd /compat/linux
rpm2cpio < "$HOME"/Downloads/"$GConfRPM" | cpio -id
rpm2cpio < "$HOME"/Downloads/"$ORBitRPM" | cpio -id
rpm2cpio < "$HOME"/Downloads/"$SlackRPM" | cpio -id || echo 'FAILED TO INSTALL SLACK in /compat/linux'

/compat/linux/sbin/ldconfig -r /compat/linux -i

echo 'Please make sure /compat/linux/usr/bin is in your $PATH'
