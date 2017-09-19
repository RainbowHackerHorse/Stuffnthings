#!/bin/sh
# Script to download and install Linux Slack Client on FreeBSD

set -x
set -e

SlackVER="2.8.0-0.1.fc21"
SlackRPM="slack-$SlackVER.x86_64.rpm"
SlackMirror="https://downloads.slack-edge.com/linux_releases"
LinABI="linux-c7"
LinVer="el7"
LinProcLine="linprocfs   /compat/linux/proc	linprocfs	rw	0	0"
TMPfs="tmpfs    /compat/linux/dev/shm	tmpfs	rw,mode=1777	0	0"
LinMirror="http://mirror.centos.org/centos/7.4.1708/os/x86_64/Packages"
GConfVer="3.2.6-8"
GConfPKG="$GConfVer.$LinVer.x86_64"
GConfRPM="GConf2-$GConfPKG.rpm"
ORBitVer="2.14.19-13"
ORBitPKG="$ORBitVer.$LinVer.x86_64"
ORBitRPM="ORBit2-$ORBitPKG.rpm"
RPMDir="$HOME/Downloads"
PKGlist="rpm4 ca_root_nss libXScrnSaver libsecret gconf2 gcc"

# Set Up Dependencies
if ! pkg info "$LinABI"; then 
	pkg install -y "$LinABI"
	echo "$LinProcLine" >> /etc/fstab
	echo "$TMPfs" >> /etc/fstab
	mount linprocfs
	mount tmpfs
fi
for i in $PKGlist; do
	if ! pkg info "$i"; then
   		pkg install -y "$i"
	fi
done

if [ ! -d "$RPMDir" ]; then
	mkdir "$RPMDir"
fi
# Linking slack provided libs
echo "/usr/lib/slack" >> /compat/linux/etc/ld.so.conf

cd "$RPMDir"
fetch "$LinMirror/$GConfRPM"
fetch "$LinMirror/$ORBitRPM"
fetch "$SlackMirror/$SlackRPM"

cd /compat/linux
rpm2cpio < "$RPMDir"/"$GConfRPM" | cpio -id
rpm2cpio < "$RPMDir"/"$ORBitRPM" | cpio -id
rpm2cpio < "$RPMDir"/"$SlackRPM" | cpio -id || echo 'FAILED TO INSTALL SLACK in /compat/linux'

/compat/linux/sbin/ldconfig -r /compat/linux -i

echo 'Please make sure /compat/linux/usr/bin is in your $PATH'
