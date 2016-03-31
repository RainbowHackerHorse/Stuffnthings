#!/bin/sh
# Quick and dirty script to get Linode Longview working when you cant use the RPM.
# Licensed under a BSD 2-clause license and © Rainbow
# Please see https://github.com/RainbowHackerHorse/Stuffnthings/blob/master/LICENSE
# for license details

# THIS IS NOT AN AUTOMATED SCRIPT. IT REQUIRES HUMAN INTERVENTION.

set -e
if cat /etc/redhat-release | grep -q 7; then
	echo "Detected CentOS 7"
	wget https://yum-longview.linode.com/centos/7/noarch/linode-longview-1.1-4.noarch.rpm
elif cat /etc/redhat-release | grep -q 6; then
	echo "Detected CentOS 6"
	wget https://yum-longview.linode.com/centos/6/noarch/linode-longview-1.1-4.noarch.rpm
fi
wget https://raw.githubusercontent.com/linode/longview/master/Extras/install-dependencies.sh
sed -i.bak 's/\/tmp/\~/g' install-dependencies.sh 
bash install-dependencies.sh
#I'm just fumbling with perl deps at this point. jesus.
# Next line because for some reason longview cant find half the stuff installed by install-dependancies.sh so whatever,
# let's just install things globally and figure it out later. I'm a bad person for doing this ._.
# export PERL_MM_USE_DEFAULT=1
# export PERL_EXTUTILS_AUTOINSTALL="--defaultdeps"
cpan install LWP::UserAgent Crypt::SSLeay IO::Socket::INET6 Linux::Distribution JSON::PP JSON Log::LogLite Try::Tiny DBI
mkdir shortgaze
mv linode-longview-1.1-4.noarch.rpm ./shortgaze/
cd shortgaze
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
service longview start
chkconfig longview on
echo "Longview is now installed."
