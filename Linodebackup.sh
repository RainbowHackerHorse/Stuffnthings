#!/bin/sh
backuplogo() {
cat <<"EOT"

.____    .__                  .___                 
|    |   |__| ____   ____   __| _/____             
|    |   |  |/    \ /  _ \ / __ |/ __ \            
|    |___|  |   |  (  <_> ) /_/ \  ___/            
|_______ \__|___|  /\____/\____ |\___  >           
        \/       \/            \/    \/            
__________                       __                
\______   \ ____   _____   _____/  |_  ____        
 |       _// __ \ /     \ /  _ \   __\/ __ \       
 |    |   \  ___/|  Y Y  (  <_> )  | \  ___/       
 |____|_  /\___  >__|_|  /\____/|__|  \___  >      
        \/     \/      \/                 \/       
__________                __                       
\______   \_____    ____ |  | ____ ________  ______
 |    |  _/\__  \ _/ ___\|  |/ /  |  \____ \/  ___/
 |    |   \ / __ \\  \___|    <|  |  /  |_> >___ \ 
 |______  /(____  /\___  >__|_ \____/|   __/____  >
        \/      \/     \/     \/     |__|       \/ 
        
This script is released under a Simplified 2-Clause BSD license. Support 
truly Free software, and use a BSD license for your projects. 
GPL restrictions just make it Open, not Free.

This script is intended to be run on a Linode from Rescue Mode and backup to a remote server as an IMG file.
Images are stored in the specified User\'s directory as a LinBackup-$Date.img file
It can differentiate between Xen and KVM.

EOT
}
#Define variables here later
DATEVAR=$(date "+%Y-%m-%d")
# Ask for $REMOTEUSER

if ls /dev | grep -q xvda; then
  echo "XEN Linode, Backing up /dev/xvda"
  DISK=xvda
elif ls /dev | grep -q sda; then
  echo "KVM Linode, Backing up /dev/sda"
  DISK=sda
fi

dd if=/dev/$DISK | ssh $REMOTEUSER@$IPADDRESS "dd of=/home/$USER/LinBackup-$DATEVAR.img"
exit 0
