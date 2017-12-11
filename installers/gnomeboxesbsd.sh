#!/bin/sh
BOXES_VERSION=3.26
BOXES_PATCH=2
DOWNLOADDIR=/tmp/box-download
BOXESWORKDIR="${DOWNLOADDIR}"/boxessrc
BOXESBUILDDIR="${BOXESWORKDIR}"/gnome-boxes-"${BOXES_VERSION}"."${BOXES_PATCH}"
BOXES_GITSOURCE_URL=https://github.com/GNOME/gnome-boxes/archive/v${BOXES_VERSION}.tar.gz
BOXES_SOURCE_URL=https://download.gnome.org/sources/gnome-boxes/${BOXES_VERSION}/gnome-boxes-${BOXES_VERSION}.${BOXES_PATCH}.tar.xz

# Build Dependencies
pkg install -y ca_root_nss libvirt-glib qemu libosinfo libgudev gtk3 clutter-gtk3
# Runtime Dependencies
pkg install -y shared-mime-info mtools
# Undocumented dependencies that are still needed by ./configure
pkg install -y gobject-introspection pkgconf itstool gtk-vnc libsecret spice-gtk webkit2-gtk3 glib tracker vala gmake gettext
# Currently needs glib-2.52.0, FreeBSD only has glib-2.50.2. See if replace workaround works and the setting is just dumb.
if [ ! -d "${DOWNLOADDIR}" ]; then
	mkdir "${DOWNLOADDIR}"
fi
if [ ! -d "${BOXESWORKDIR}" ]; then
	mkdir "${BOXESWORKDIR}"
fi
cd "${DOWNLOADDIR}" || exit 1

# Choose FromGit() or FromSource()
FromSource() {
	fetch "${BOXES_SOURCE_URL}"
	tar xvfJ gnome-boxes-"${BOXES_VERSION}"."${BOXES_PATCH}".tar.xz -C "${BOXESWORKDIR}"
}
FromGit() {
	pkg install -y autoconf
	fetch "${BOXES_GITSOURCE_URL}"
	tar xvfz v"${BOXES_VERSION}"."${BOXES_PATCH}".tar.gz -C "${BOXESWORKDIR}"
}

FromSource
#FromGit

cd "${BOXESBUILDDIR}" || exit 1
# Magical SED work to replace
sed -i.bak 's#GLIB\_MIN\_VERSION\=2\.52\.0#GLIB\_MIN\_VERSION\=2\.50\.2#g' "${BOXESBUILDDIR}"/configure
./configure
cd "${BOXESBUILDDIR}"/data || exit 1
cp org.gnome.Boxes.desktop.in org.gnome.Boxes.desktop
cd "${BOXESBUILDDIR}" || exit 1
# Set GCC
CC=gcc6
CXX=g++6
CPP=cpp6
GCJ=gcj6
export CC CXX CPP GCJ

gmake
