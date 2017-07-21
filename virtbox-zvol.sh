#!/bin/sh
ZROOT=$(zpool list | awk '{ zPools[NR-1]=$1 } END { print zPools[2] }')
USER=$(whoami)
SIZE=10G
VOLNAME=DIE

getargz() {
	while :; do
		case $1 in
			-h|--help)
				show_help
				exit
				;;
			-s|--size)
				if [ "$2" ]; then
					SIZE=$2
					# Add input check to ensure proper syntax
					shift
				else
					echo "Please provide a size!"
					exit 1
				fi
				;;
			-u|--user)
				if [ "$2" ]; then
					USER=$2
					# Add input check to ensure proper syntax
					shift
				else
					echo "Please provide a username!"
					exit 1
				fi
				;;
			-v|--volume)
				if [ "$2" ]; then
					VOLNAME=$2
					# Add input check to ensure proper syntax
					shift
				else
					echo "Please provide a zvol name!"
					exit 1
				fi
				;;
			*)
				break
		esac
		shift
	done
}

show_help() {
	cat << 'EOT'
	'-h | --help
	Shows this help

	-s | --size
	Allows you to set a size for the zvol.
	Size should be set using M or G.
	Example: --size 10G | -s 1024M
	Defaults to 10G if nothing specified.

	-u | --user
	Sets the user under which we grant permissions for the zvol.
	Defaults to your username if nothing is specified.

	-v | --volume
	MANDATORY OPTION!!
	Sets the zvol name. If nothing is specified or this option is left off,
	the command will FAIL!
	'
EOT
}

checkzvol() {
	if [ "${VOLNAME}" = 'DIE' ]; then
		echo "Please provide a zvol name. See --help for more information."
		exit 1
	fi 
}

actually_run_stuff() {
	sudo zfs create -V "${SIZE}" "${ZROOT}"/"${VOLNAME}"
	sudo chown "${USER}" /dev/zvol/rdsk/"${ZROOT}"/"${VOLNAME}"
	VBoxManage internalcommands createrawvmdk \
		-filename /home/"${USER}"/VBoxdisks/"${VOLNAME}".vmdk \
		-rawdisk /dev/zvol/rdsk/"${ZROOT}"/"${VOLNAME}"
	VBoxManage registerimage disk /home/"${USER}"/VBoxdisks/"${VOLNAME}".vmdk
	exit 0
}

getargz "$@" || exit 1
checkzvol || exit 1
actually_run_stuff || exit 1
