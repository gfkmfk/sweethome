#!/usr/bin/env bash
# Domoticz: Open Source Home Automation System
# (c) 2012, 2016 by GizMoCuz
# Big thanks to Jacob Salmela! (Sorry i modified your domoticz install script ;)
# http://www.domoticz.com
# Installs Domoticz
#
# Domoticz is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.

# Donations are welcome via the website or application
#
# Install with this command (from your Pi):
#
# curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/install-domoticz.sh | bash

set -e
######## VARIABLES #########
setupVars=/etc/domoticz/setupVars.conf

useUpdateVars=false

Dest_folder="/var/domoticz"
IPv4_address=""
Enable_http=true
Enable_https=true
HTTP_port="80"
HTTPS_port="443"
Current_user=""

lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

OS=`lowercase \`uname -s\``
MACH=`uname -m`
if [ ${MACH} = "armv6l" ]
then
 MACH="armv7l"
fi

# Find the rows and columns will default to 80x24 is it can not be detected
screen_size=$(stty size 2>/dev/null || echo 24 80) 
rows=$(echo $screen_size | awk '{print $1}')
columns=$(echo $screen_size | awk '{print $2}')


######## Undocumented Flags. Shhh ########
skipSpaceCheck=false
reconfigure=false

######## FIRST CHECK ########
# Must be root to install
echo ":::"
if [[ ${EUID} -eq 0 ]]; then
	echo "::: You are root."
else
	echo "::: Script called with non-root privileges. The Domoticz installs server packages and configures"
	echo "::: system networking, it requires elevated rights. Please check the contents of the script for"
	echo "::: any concerns with this requirement. Please be sure to download this script from a trusted source."
	echo ":::"
	echo "::: Detecting the presence of the sudo utility for continuation of this install..."

	if [ -x "$(command -v sudo)" ]; then
		echo "::: Utility sudo located."
		exec curl -sSL https://github.com/gfkmfk/sweethome/raw/master/scripts/install-domoticz.sh | sudo bash "$@"
		exit $?
	else
		echo "::: sudo is needed for the Web interface to run domoticz commands.  Please run this script as root and it will be automatically installed."
		exit 1
	fi
fi

# Compatibility

if [ -x "$(command -v apt-get)" ]; then
	#Debian Family
	#############################################
	PKG_MANAGER="apt-get"
	PKG_CACHE="/var/lib/apt/lists/"
	UPDATE_PKG_CACHE="${PKG_MANAGER} update"
	PKG_UPDATE="${PKG_MANAGER} upgrade"
	PKG_INSTALL="${PKG_MANAGER} --yes --fix-missing install"
	# grep -c will return 1 retVal on 0 matches, block this throwing the set -e with an OR TRUE
	PKG_COUNT="${PKG_MANAGER} -s -o Debug::NoLocking=true upgrade | grep -c ^Inst || true"
	INSTALLER_DEPS=( apt-utils whiptail git)
	domoticz_DEPS=( curl unzip wget sudo cron libudev-dev)

        DEBIAN_ID=$(grep -oP '(?<=^ID=).+' /etc/*-release | tr -d '"')
        DEBIAN_VERSION=$(grep -oP '(?<=^VERSION_ID=).+' /etc/*-release | tr -d '"')

	if test ${DEBIAN_VERSION} -lt 10
	then
		domoticz_DEPS=( ${domoticz_DEPS[@]} libcurl3 )
	else
		domoticz_DEPS=( ${domoticz_DEPS[@]} libcurl4 libusb-0.1)
	fi;

	package_check_install() {
		dpkg-query -W -f='${Status}' "${1}" 2>/dev/null | grep -c "ok installed" || ${PKG_INSTALL} "${1}"
	}
elif [ -x "$(command -v rpm)" ]; then
	# Fedora Family
	if [ -x "$(command -v dnf)" ]; then
		PKG_MANAGER="dnf"
	else
		PKG_MANAGER="yum"
	fi
	PKG_CACHE="/var/cache/${PKG_MANAGER}"
	UPDATE_PKG_CACHE="${PKG_MANAGER} check-update"
	PKG_UPDATE="${PKG_MANAGER} update -y"
	PKG_INSTALL="${PKG_MANAGER} install -y"
	PKG_COUNT="${PKG_MANAGER} check-update | egrep '(.i686|.x86|.noarch|.arm|.src)' | wc -l"
	INSTALLER_DEPS=( procps-ng newt git )
	domoticz_DEPS=( curl libcurl4 unzip wget findutils cronie sudo domoticz_DEP)
	if grep -q 'Fedora' /etc/redhat-release; then
		remove_deps=(epel-release);
		domoticz_DEPS=( ${domoticz_DEPS[@]/$remove_deps} );
	fi
	package_check_install() {
		rpm -qa | grep ^"${1}"- > /dev/null || ${PKG_INSTALL} "${1}"
	}
else
	echo "OS distribution not supported"
	exit
fi

####### FUNCTIONS ##########
spinner() {
	local pid=$1
	local delay=0.50
	local spinstr='/-\|'
	while [ "$(ps a | awk '{print $1}' | grep "${pid}")" ]; do
		local temp=${spinstr#?}
		printf " [%c]  " "${spinstr}"
		local spinstr=${temp}${spinstr%"$temp"}
		sleep ${delay}
		printf "\b\b\b\b\b\b"
	done
	printf "    \b\b\b\b"
}

find_current_user() {
	# Find current user
	Current_user=${SUDO_USER:-$USER}
	echo "::: Current User: ${Current_user}"
}

find_IPv4_information() {
	# Find IP used to route to outside world
	IPv4dev=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++)if($i~/dev/)print $(i+1)}')
	IPv4_address=$(ip -o -f inet addr show dev "$IPv4dev" | awk '{print $4}' | awk 'END {print}')
	IPv4gw=$(ip route get 8.8.8.8 | awk '{print $3}')
}

verifyFreeDiskSpace() {

	# 50MB is the minimum space needed
	# - Fourdee: Local ensures the variable is only created, and accessible within this function/void. Generally considered a "good" coding practice for non-global variables.
	echo "::: Verifying free disk space..."
	local required_free_kilobytes=51200
	local existing_free_kilobytes=$(df -Pk | grep -m1 '\/$' | awk '{print $4}')

	# - Unknown free disk space , not a integer
	if ! [[ "${existing_free_kilobytes}" =~ ^([0-9])+$ ]]; then
		echo "::: Unknown free disk space!"
		echo "::: We were unable to determine available free disk space on this system."
		echo "::: You may override this check and force the installation, however, it is not recommended"
		echo "::: To do so, pass the argument '--i_do_not_follow_recommendations' to the install script"
		echo "::: eg. curl -L https://install.domoticz.com | bash /dev/stdin --i_do_not_follow_recommendations"
		exit 1
	# - Insufficient free disk space
	elif [[ ${existing_free_kilobytes} -lt ${required_free_kilobytes} ]]; then
		echo "::: Insufficient Disk Space!"
		echo "::: Your system appears to be low on disk space. Domoticz recommends a minimum of $required_free_kilobytes KiloBytes."
		echo "::: You only have ${existing_free_kilobytes} KiloBytes free."
		echo "::: If this is a new install you may need to expand your disk."
		echo "::: Try running 'sudo raspi-config', and choose the 'expand file system option'"
		echo "::: After rebooting, run this installation again. (curl -L https://install.domoticz.com | bash)"

		echo "Insufficient free space, exiting..."
		exit 1

	fi

}

chooseServices() {
	Enable_http=true
	Enable_https=true
	HTTP_port="80"
	HTTPS_port="443"
}

chooseDestinationFolder() {
	Dest_folder="/var/domoticz"
}

stop_service() {
	# Stop service passed in as argument.
	echo ":::"
	echo -n "::: Stopping ${1} service..."
	if [ -x "$(command -v service)" ]; then
		service "${1}" stop &> /dev/null & spinner $! || true
	fi
	echo " done."
}

start_service() {
	# Start/Restart service passed in as argument
	# This should not fail, it's an error if it does
	echo ":::"
	echo -n "::: Starting ${1} service..."
	if [ -x "$(command -v service)" ]; then
		service "${1}" restart &> /dev/null  & spinner $!
	fi
	echo " done."
}

enable_service() {
	# Enable service so that it will start with next reboot
	echo ":::"
	echo -n "::: Enabling ${1} service to start on reboot..."
	if [ -x "$(command -v service)" ]; then
		update-rc.d "${1}" defaults &> /dev/null  & spinner $!
	fi
	echo " done."
}

update_package_cache() {
	#Running apt-get update/upgrade with minimal output can cause some issues with
	#requiring user input (e.g password for phpmyadmin see #218)

	#Check to see if apt-get update has already been run today
	#it needs to have been run at least once on ne…
