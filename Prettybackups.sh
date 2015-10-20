#!/bin/sh
backuplicense() {
cat <<"EOT"
This script is released under a Simplified 2-Clause BSD license. Support 
truly Free software, and use a BSD license for your projects. 
GPL restrictions just make it Open, not Free.

This script is intended to be run on a Linode from Rescue Mode and backup to a remote server as an IMG file.
Images are stored in the specified User's directory as a LinBackup-$Date.img file
It can differentiate between Xen and KVM.

EOT
}
#Define variables here later
DATEVAR=$(date "+%Y-%m-%d")

tput clear
tput cup 3 15
tput setaf 3
echo "Pretty Linode Remote Backup Script"
tput sgr0
tput cup 5 17
tput rev
echo "Is your Linode Xen or KVM?"
tput sgr0
tput cup 7 15
echo "1. Xen"
tput cup 8 15
echo "2. KVM"
tput bold
tput cup 12 15
$DISK (read -p "Enter your choice [1-2] ")
tput clear
tput cup 5 17
tput rev
echo "Enter your username@IPADDRESS for the remote machine"
tput sgr0
tput bold
tput cup 12 15
$REMOTEADDR(read -p "")
tput clear

dd if=/dev/$DISK | ssh $REMOTEADD "dd of=/home/$USER/LinBackup-$DATEVAR.img
exit 0
