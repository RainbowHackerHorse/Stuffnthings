#!/bin/bash
# This script is useful if you borked your Ubuntu Linode during an update.
# Grab it in rescue mode and run. Simple and easy! All it does is mount your disk and reconfobulate dpkg stoofs.
if ls /dev | grep -q xvda; then
  echo "XEN Linode, setting /dev/xvda"
  DISK=xvda
elif ls /dev | grep -q sda; then
  echo "KVM Linode, setting to /dev/sda"
  DISK=sda
fi
mount /dev/$DISK /mnt
mount -t proc proc /mnt/proc 
mount -t sysfs sys /mnt/sys 
mount -o bind /dev /mnt/dev/ 
mount -t devpts pts /mnt/dev/pts/ 
cat > /mnt/root/ubfixme2.sh << EOF
dpkg --configure -a 
apt-get update 
apt-get upgrade
EOF
chroot /media/sda /root/ubfixme2.sh
echo "Things should be fixed! Reboot and let's see!"
exit 0
