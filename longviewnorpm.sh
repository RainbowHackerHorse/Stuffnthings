#!/bin/sh
# Quick and dirty script to get Linode Longview working when you cant use the RPM.
# Licensed under a BSD 2-clause license and © Rainbow
# Please see https://github.com/RainbowHackerHorse/Stuffnthings/blob/master/LICENSE
# for license details

set -e
wget https://yum-longview.linode.com/centos/7/noarch/linode-longview-1.1-4.noarch.rpm
rpm2cpio linode-longview-1.1-4.noarch.rpm | cpio -idmv
cd ./opt
mv ./* /opt/
cd ../etc
mv ./linode /etc/
mv ./init.d/longview /etc/init.d/
echo "Adding API Key"
echo "If you don't have an API Key, please see instructions at: https://www.linode.com/docs/platform/longview/longview#fedora-and-centos Step 11"
echo;echo -n "  Enter your Longview API Key: ";read LKEY
echo $LKEY > /etc/linode/longview.key
echo "Longview is now installed. Please restart your Linode and re-login to the Linode Manager"
