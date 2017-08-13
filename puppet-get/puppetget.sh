#!/bin/sh

#puppet module downloader and renamer
# https://forge.puppet.com/v3/files/zleslie-jail-3.1.0.tar.gz
URLGET="${1}"
GETDIR="${HOME}"/puppetget
PFILENAME=$(echo "${URLGET}" | awk 'BEGIN{ FS = "/" } {print $6}')
PMODULENAME=$(echo "${PFILENAME}" | awk 'BEGIN{ FS = "." } {print $1"."$2"."$3}')
PNUMODULENAME=$(echo "${PFILENAME}" | awk 'BEGIN{ FS = "-" } {print $2}')

# Ensure creation of Module directory
if [ ! -d "${GETDIR}" ] ;then
	mkdir "${GETDIR}"
fi

cd "${GETDIR}" || exit

wget "${URLGET}"

#Untar
tar xvfz "${PFILENAME}"

#Strip everything but the module name
mv "${PMODULENAME}" "${PNUMODULENAME}"