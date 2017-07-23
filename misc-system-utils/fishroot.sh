#!/bin/sh
echo "Fixin yur shit bruh!"
rm -rf /home
zfs rename zroot/usr/home zroot/home
zfs set mountpoint=/home zroot/home
ln -s /home /usr/home
echo "Done!"
