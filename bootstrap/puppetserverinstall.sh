#!/bin/sh
# Puppet master install script
# written by Rainbow <rainbow@hackerhorse.consulting>
# This script is opensource software released under the terms of the BSD 2-clause license
# $1 is your github account
# $2 is your repo

if [ ! "$(whoami)" = root ]; then
	echo "Please run as root"
	exit 1
fi

pkg update -f
pkg install -y puppetserver puppet4 rubygem-facter git
rm -rf /usr/local/etc/puppet
cd /usr/local/etc

# add ssh deploy key

if [ ! -f /root/.ssh/id_rsa.pub ]; then
	echo "Generating Deploy Key with no Passphrase"
	ssh-keygen -b 4096 -t rsa -f /root/.ssh/id_rsa -q -P ""
fi

echo "Please Enter this key at https://github.com/$1/$2/settings/keys"
cat /root/.ssh/id_rsa.pub
read -rp "Press any key to continue... "

git clone git@github.com:"$1"/"$2".git
ln -s /usr/local/etc/"$2" /usr/local/etc/puppet
echo "Completed install. You can now run service puppetserver onestart"
exit
