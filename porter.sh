#!/bin/sh
usage() {
	cat <<EOF
usage: porter (bootstrap/fetch/update)
Commands:
	update		Update pkgsrc
	upgrade		Upgrade ports
EOF
	exit 0
}
if [[ ${1} == "update" ]];
	then
	echo "Updating pkgsrc..."
	cd $HOME/pkgsrc
	env CVS_RSH=ssh cvs up -dP
elif [[ ${1} == "upgrade" ]];
	then
	echo "Upgrading Installed Packages..."
	cd $HOME/pkgsrc
	pkg_rolling-replace
elif [[ ${1} == "" ]];
	then
	usage
fi
