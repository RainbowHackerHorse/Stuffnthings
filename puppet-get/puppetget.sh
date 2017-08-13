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
	echo "Creating ${GETDIR}"
	sleep 2
	mkdir "${GETDIR}"
fi

cd "${GETDIR}" || exit

#Download Tarball
echo "Downloading ${PFILENAME}"
sleep 2
wget "${URLGET}"

#Untar
echo "Untarring to ${PMODULENAME}"
sleep 2
tar xvfz "${PFILENAME}"

#Strip everything but the module name
echo "Renaming ${PMODULENAME} to ${PNUMODULENAME}"
sleep 2
mv "${PMODULENAME}" "${PNUMODULENAME}"

# Delete tarball
echo "Deleting ${PFILENAME}"
sleep 2
rm "${GETDIR}"/"${PFILENAME}"