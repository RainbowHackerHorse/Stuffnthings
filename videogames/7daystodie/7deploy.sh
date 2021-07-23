#!/bin/sh
## Set Up 7 Days to Die Server

function 7di_usersetup(){
	adduser --home /home/steam --disabled-password --uid 1000 steam
}

function 7di_reposetup(){
	add-apt-repository multiverse
	dpkg --add-architecture i386
	apt update
}

function 7di_steaminstall(){
	apt-get upgrade -y
	apt install -y lib32gcc-s1 steamcmd libsdl2-2.0-0:i386 tmux
}

function 7di_swappy(){
	fallocate -l 8G /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
	echo '/dev/disk/by-id/scsi-0DO_Volume_steam-nyc3-01 /home/steam ext4 defaults,nofail,discard 0 0' >> /etc/fstab
	mount -a
	swapon --show
}

function 7di_steamdothedoing(){
	if [ ! -d /home/steam/Steam/7DaystoDie ]; then
		mkdir /home/steam/Steam/7DaystoDie
		chown -R steam:steam /home/steam/Steam/7DaystoDie
		steamcmd +login anonymous +force_install_dir /home/steam/Steam/7DaystoDie +app_update 294420 +quit
	else
		# This isn't very clean, I should run a check here to remove only the needful folders,
		# then return a custom error code that tells the script to rerun this function instead
		# of duplicating lines of code
		rm -rf /home/steam/Steam/7DaystoDie
		mkdir /home/steam/Steam/7DaystoDie
		chown -R steam:steam /home/steam/Steam/7DaystoDie
		steamcmd +login anonymous +force_install_dir /home/steam/Steam/7DaystoDie +app_update 294420 +quit
	fi
	
}

function main(){
	# I should really add error checking and graceful exits
	7di_usersetup
	7di_reposetup
	7di_steaminstall
	7di_swappy
	7di_steamdothedoing
	echo "Run ./Steam/7DaystoDie/startserver.sh -configfile=serverconfig.xml to launch the server as the steam user"
	echo "Make sure to edit the serverconfig first!"
	# Instead of this, I could and should probably create a service file. I don't want to write a systemd service file. ew.
	# I'll do this if I ever wrangle the game to run under FreeBSD. Someone else can write the Linux file.
	echo "telnet localhost 8081 to see the console"
}

main
exit 0
