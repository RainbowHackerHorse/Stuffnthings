#!/bin/sh
# Deploy puppet on a remote server

LOCALSERVER=NULL
PUPPETHOST=NULL
INSTALL_ADDITIONAL_PKGS=NO
EXITNAO=NO

p4d_getargs() {
	while :; do
		case $1 in
			-h|--help)
				p4d_showhelp
				exit
			;;
			-l|--local)
				if [ "$2" ]; then
					LOCALSERVER="${2}"
					shift
				else
					echo "Please specify this node's name"
					exit 1
				fi
			;;
			-p|--puppetserver)
				if [ "$2" ]; then
					PUPPETHOST="${2}"
					shift
				else
					echo "Please specify a puppetserver"
					exit 1
				fi
			;;
			-a)
				INSTALL_ADDITIONAL_PKGS=YES
			;;
			*)
				break
			;;
		esac
		shift
	done
}

p4d_showhelp() {
	cat << 'EOT'
This is a simple shell script to bootstrap Puppet4 on a FreeBSD server.
Usage:
freebsd-puppet4deploy.sh --local MY.PUPPET.CLIENT --puppetserver MY.PUPPET.SERVER
It is as simple as that!
Please make sure that --local is set to the same as your node definition in site.pp
EOT
return 0
}

p4d_checkargs() {
	if [ "${LOCALSERVER}" = NULL ]; then
		echo "Error! Please use -l or --local to set the hostname of this server!"
		echo "It MUST correspond with your puppet node definition in site.pp"
		EXITNAO=YES
	fi
	if [ "${PUPPETHOST}" = NULL ]; then
		echo "Error! Please use -p or --puppetserver to set the hostname of your puppet server!"
		echo "Otherwise, I have NO idea who I'm talking to!"
		echo "This MUST be an FQDN or routable IP Address!"
		EXITNAO=YES
	fi
	if [ "${EXITNAO}" = YES ]; then
		exit 1
	fi
	return 0
}

main() {
	ALWAYS_ASSUME_YES=yes pkg update
	pkg install -y puppet4
	if [ "${INSTALL_ADDITIONAL_PKGS}" = YES ]; then
		pkg install -y mosh tmux
	fi
	hostname "${LOCALSERVER}"
	puppet agent --server "${PUPPETHOST}" --waitforcert 120 --test
	return 0
}
p4d_getargs "$@"
p4d_checkargs
main
exit
