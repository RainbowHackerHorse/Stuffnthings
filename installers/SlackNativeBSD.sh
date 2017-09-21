#!/bin/sh
# Script to download and install Linux Slack Client on FreeBSD natively
# Some of the finer details from:
# https://github.com/cstroe/electron/pull/1/files
# Changes were merged into:
# https://github.com/RainbowHackerHorse/electron/tree/feature/freebsd-native
# Many thanks to @BinaryMuse on twitter for clarifying some Electron stuff
# and to Sarah at Slack support for not telling me to go away when I asked her
# insane questions about Slack.

set -x
set -e

SlackVER="2.8.0-0.1.fc21"
SlackRPM="slack-$SlackVER.x86_64.rpm"
SlackMirror="https://downloads.slack-edge.com/linux_releases"
DownloadDir="$HOME/Downloads"
PKGlist="rpm4 ca_root_nss libXScrnSaver libsecret gconf2 gcc python27 node clang39 libnotify gtk20 git"

installpkgs() {
	# Set Up Dependencies
	for i in $PKGlist; do
		if ! pkg info "$i"; then
	   		pkg install -y "$i"
		fi
	done	
}

fetchrpms() {
	cd "$DownloadDir"
	fetch "$SlackMirror/$SlackRPM"
}

extractrpm() {
	cd "$DownloadDir"
	mkdir SlackLinux
	cd SlackLinux
	rpm2cpio ../"$SlackRPM" | cpio -idmv

}

fetch_libchromiumcontent() {
	cd "$DownloadDir"
	git clone git@github.com:electron/libchromiumcontent.git
}

build_libchromiumcontent() {
	cd "$DownloadDir"/libchromiumcontent
	./script/bootstrap
	./script/update -t x64
	./script/build -t x64

}

fetch_electron() {
	cd "$DownloadDir"
	git clone git@github.com:RainbowHackerHorse/electron.git
	cd electron
	git checkout feature/freebsd-native
}

build_electron() {
	cd "$DownloadDir"/electron
	CC_SRC=../libchromiumcontent/src
	./script/bootstrap.py -v --libcc_source_path "$CC_SRC" \
	--libcc_shared_library_path "$CC_SRC/out-x64/shared_library" \
	--libcc_static_library_path "$CC_SRC/out-x64/shared_library"
	./script/build.py
	./script/create-dist.py
	rm rf ./out/R
	if ! [ -d "$DownloadDir"/slack-native-dist ]; then
		mkdir "$DownloadDir"/slack-native-dist
	fi
	cp ./out/D/electron "$DownloadDir"/slack-native-dist/slack
}

create_electron_dist() {
	if ! [ -d "$DownloadDir"/slack-native-dist/usr/local/share ]; then
		mkdir "$DownloadDir"/slack-native-dist/usr/local/share
	fi
	cp "$DownloadDir"/SlackLinux/usr/share/pixmaps/slack.png \
	"$DownloadDir"/slack-native-dist/usr/local/share/slack.png
	cp -r "$DownloadDir"/SlackLinux/usr/lib \
	"$DownloadDir"/slack-native-dist/usr/local/lib
	rm "$DownloadDir"/slack-native-dist/usr/local/lib/slack/slack
	mv "$DownloadDir"/slack-native-dist/slack \
	"$DownloadDir"/slack-native-dist/usr/local/lib/slack/slack
}

installslack() {
	# Copy files from "$DownloadDir"/slack-native-dist to their real
	# locations and then symlink
	ln -s /usr/local/lib/slack/slack /usr/local/bin/slack

}

if [ ! -d "$DownloadDir" ]; then
	mkdir "$DownloadDir"
fi
installpkgs
fetchrpms
extractrpm
fetch_libchromiumcontent
build_libchromiumcontent
fetch_electron
build_electron
create_electron_dist
# installslack
exit 0
