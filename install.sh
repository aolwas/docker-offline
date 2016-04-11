#!/bin/sh
set -e

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

case "$(uname -m)" in
	*64)
		;;
	*)
		echo >&2 'Error: you are not using a 64bit platform.'
		echo >&2 'Docker currently only supports 64bit platforms.'
		exit 1
		;;
esac

# if command_exists daomonit ; then
# 	echo >&2 'Warning: "daomonit" command appears to already exist.'
# 	echo >&2 'Please ensure that you do not already have daomonit installed.'
# 	echo >&2 'You may press Ctrl+C now to abort this process and rectify this situation.'
# 	( set -x; sleep 20 )
# fi

user="$(id -un 2>/dev/null || true)"

sh_c='sh -c'
if [ "$user" != 'root' ]; then
	if command_exists sudo; then
		sh_c='sudo -E sh -c'
	elif command_exists su; then
		sh_c='su -c'
	else
		echo >&2 'Error: this installer needs the ability to run commands as root.'
		echo >&2 'We are unable to find either "sudo" or "su" available to make this happen.'
	fi
fi

# perform some very rudimentary platform detection
lsb_dist=''
if command_exists lsb_release; then
	lsb_dist="$(lsb_release -si)"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/lsb-release ]; then
	lsb_dist="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/debian_version ]; then
	lsb_dist='debian'
fi
if [ -z "$lsb_dist" ] && [ -r /etc/fedora-release ]; then
	lsb_dist='fedora'
fi
if [ -z "$lsb_dist" ] && [ -r /etc/os-release ]; then
	lsb_dist="$(. /etc/os-release && echo "$ID")"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/centos-release ]; then
	lsb_dist="$(cat /etc/*-release | head -n1 | cut -d " " -f1)"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/redhat-release ]; then
	lsb_dist="$(cat /etc/*-release | head -n1 | cut -d " " -f1)"
fi
lsb_dist="$(echo $lsb_dist | cut -d " " -f1)"

not_support () {
	echo
	echo "Docker not support ${lsb_dist} ${lsb_version} now"
	echo
	exit 0
}

lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
case "$lsb_dist" in
	ubuntu)
		(
			echo " * Installing Docker..."
			if command_exists lsb_release; then
				lsb_version="$(lsb_release --release | cut -f2)"
			fi
			$sh_c "dpkg -i ubuntu${lsb_version}/*.deb"

		)
		exit 0
		;;

	centos|rhel)
		(
			echo " * Installing Docker..."
			dist_version="$(rpm -q --whatprovides redhat-release --queryformat "%{VERSION}\n" | sed 's/\/.*//' | sed 's/\..*//' | sed 's/Server*//')"
			$sh_c "yum --nogpgcheck localinstall -y centos${dist_version}/*.rpm"

		)
		exit 0
		;;
esac

$sh_c 'curl -sSL https://get.daocloud.io/docker/ | sh'
exit 0
;;
