#!/bin/sh
#
# Generate a civocloud/openstack FreeBSD image from a vanilla install
# (c) 2018 RainbowHackerHorse
# You can find the primary repository at https://github.com/RainbowHackerHorse/Stuffnthings/cloud/civocloud
# This buildscript is released under the 2-Clause BSD license.

# Install packages
env ASSUME_ALWAYS_YES=YES pkg bootstrap
pkg install -y py27-cloud-init sudo ca_root_nss

# Edit network interface
sed -i -e 's/em0/vtnet0/g' /etc/rc.conf

# Prepare config files
echo 'cloudinit_enable="YES"' >> /etc/rc.conf
echo 'console="comconsole,vidconsole"' >> /boot/loader.conf
echo 'autoboot_delay="10"' >> /boot/loader.conf
echo 'vfs.zfs.arc_max=512M' >> /boot/loader.conf
echo 'freebsd ALL=(ALL) NOPASSWD: ALL' > /usr/local/etc/sudoers.d/10-cloudinit
cd /root
fetch "https://raw.githubusercontent.com/RainbowHackerHorse/Stuffnthings/master/cloud/civocloud/freebsd-openstack-zsize.sh"
chmod +x /root/freebsd-openstack-zsize.sh
mv /root/freebsd-openstack-zsize.sh /usr/local/sbin/openstackresize

# Add crontab to recover and resize the disk on boot
echo "# Recover and resize the zpool on reboot" >> /etc/crontab
echo "@reboot root /usr/local/sbin/openstackresize" >> /etc/crontab

# Grab the MOTD and edit it to reflect the current FreeBSD Version
FREEBSD_VERSION_TEXT=$( uname -r | awk -F "-" '{print $1"-"$2}' )
rm /etc/motd
fetch "https://raw.githubusercontent.com/RainbowHackerHorse/Stuffnthings/master/cloud/civocloud/civo-motd"
sed -i -e "s/FREEBSD_VERSION_STRING/$FREEBSD_VERSION_TEXT/g" /root/civo-motd
rm /root/civo-motd-e
mv /root/civo-motd /etc/motd


# Clean SSH host keys
rm /etc/ssh/ssh_host*

echo "Please make sure to run 'set history = 0' before shutting down"

# Cleanup
rm /root/freebsd-openstack-build.sh

exit
