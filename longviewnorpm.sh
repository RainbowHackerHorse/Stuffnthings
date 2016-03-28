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
echo "If you haven't yet, please follow https://www.linode.com/docs/platform/longview/longview to set up your API key"
