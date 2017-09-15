#!/bin/sh
# Script to download and install Linux Slack Client on FreeBSD

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
if [ ! -d "$HOME"/Downloads ]; then
	mkdir "$HOME"/Downloads
fi
cd "$HOME"/Downloads
fetch "https://downloads.slack-edge.com/linux_releases/$SlackRPM"
cd /compat/linux
rpm2cpio < "$HOME"/Downloads/"$SlackRPM" | cpio -id