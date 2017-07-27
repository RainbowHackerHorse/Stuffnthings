#!/bin/sh
# This script is meant to set you up with a complete Slack install.
# This script comes with no warranties and I am not liable if it accidentally your Linode.
#
# Uncomment a mirror in /etc/slackpkg/mirrors
echo "http://mirrors.us.kernel.org/slackware/slackware64-14.1/" >> /etc/slackpkg/mirrors
slackpkg update
# Install Missing packages
slackpkg reinstall slackware64
slackpkg install a/* ap/* d/* f/* k/* l/* n/* t/* tcl/* y/*
slackpkg upgrade-all
