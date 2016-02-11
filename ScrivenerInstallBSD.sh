#!/bin/sh
# Prerequisites: print/linux-c6-cups-libs emulators/linux-c6 net/linux-c6-avahi-libs textproc/linux-c6-libxml2
# Missing /usr/lib/libstdc++.so.6, even though its in /usr/compat/linux/usr/lib 
# Not sure what to do, don't really care anymore
# This script gets the Linux version of Scrivener working in the Linuxulator on FreeBSD.
# At least, it should. I'm still wading through dependancy hell.
cd $HOME
mkdir /usr/compat/linux/usr/local
fetch "https://cloudsdale.hacker.horse/~rainbow/lazymirror/scrivener-1.9.0.1-i386.tar.gz"
tar xvfz scrivener-1.9.0.1-i386.tar.gz
cd scrivener-1.9.0.1-i386
cp -r $HOME/scrivener-1.9.0.1-i386/bin /usr/compat/linux/usr/local/
cp -r $HOME/scrivener-1.9.0.1-i386/lib /usr/compat/linux/usr/local/
cd
fetch "https://cloudsdale.hacker.horse/~rainbow/lazymirror/c6libs/libfreebl3.so"
mv $HOME/libfreebl3.so /usr/compat/linux/lib/
ln -s /usr/compat/linux/lib/libfreebl3.so /usr/compat/linux/usr/lib/libfreebl3.so
fetch "https://cloudsdale.hacker.horse/~rainbow/lazymirror/scrivlibs.tar.gz"
tar xvfz scrivlibs.tar.gz
mv $HOME/scrivlibs/* /usr/compat/linux/usr/local/lib/
ln -s /usr/compat/linux/usr/local/lib/libgstapp-0.10.so.0.20.0 /usr/compat/linux/usr/lib/libgstapp-0.10.so.0
ln -s /usr/compat/linux/usr/local/lib/libgstinterfaces-0.10.so.0.20.0 /usr/compat/linux/usr/lib/libgstinterfaces-0.10.so.0
ln -s /usr/compat/linux/usr/local/lib/libgstreamer-0.10.so.0.25.0 /usr/compat/linux/usr/lib/libgstreamer-0.10.so.0
ln -s /usr/compat/linux/usr/local/lib/libgstbase-0.10.so.0.25.0 /usr/compat/linux/usr/lib/libgstbase-0.10.so.0
ln -s /usr/compat/linux/usr/local/lib/libgstpbutils-0.10.so.0.20.0 /usr/compat/linux/usr/lib/libgstpbutils-0.10.so.0
ln -s /usr/compat/linux/usr/local/lib/libgstvideo-0.10.so.0.20.0 /usr/compat/linux/usr/lib/libgstvideo-0.10.so.0
