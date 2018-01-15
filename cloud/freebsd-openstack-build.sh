#!/bin/sh
#
# Generate a civocloud/openstack FreeBSD image from a vanilla install
# (c) 2018 RainbowHackerHorse
# You can find the primary repository at https://github.com/RainbowHackerHorse/StuffNThings/Cloud
# This buildscript is released under the 2-Clause BSD license.

# Install packages
env ASSUME_ALWAYS_YES=YES pkg bootstrap
pkg install -y py27-cloud-init sudo ca_root_nss

# Edit network interface
sed -i -e 's/re0/vtnet0/g' /etc/rc.conf

# Prepare config files
echo 'cloudinit_enable="YES"' >> /etc/rc.conf
echo 'console="comconsole,vidconsole"' >> /boot/loader.conf
echo 'autoboot_delay="10"' >> /boot/loader.conf
echo 'freebsd ALL=(ALL) NOPASSWD: ALL' > /usr/local/etc/sudoers.d/10-cloudinit
cd /root
fetch "https://raw.githubusercontent.com/RainbowHackerHorse/Stuffnthings/master/cloud/freebsd-openstack-zsize.sh"
chmod +x /root/freebsd-openstack-zsize.sh
exit
