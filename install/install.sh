#!/bin/bash
#2 Due to: invoke-rc.d: initscript puppetmaster, action "start" failed. 
set +e

if [ $UID != 0 ] ; then
	echo "Please use sudo or root account."
	exit
fi

pushd $(pwd)/$(dirname $0)
. ./install.cfg
. ./install.lib

if [ $# != 1 ] ; then
	_usage
else
	Puppet=$(echo $1 | tr '[:upper:]' '[:lower:]')
	case ${Puppet} in
		master) Package="puppetmaster puppet" ;;
		agent)  Package="puppet";;
		*) _usage ;;
	esac
fi

_echo "DftUser=${DftUser}"
_echo "confdir=${confdir}"

_echo "Boostraping Installation of Puppet..."
	_echo "Clean-up potential old version of puppet and puppetmaster..."
	. ./uninstall-${Puppet}.sh

	_echo "Prerequisites installation..."
	[ ! $(which lsb-release) ] && _apt-get install -y lsb-release
	DstName=$(lsb_release -c -s)
	_echo "lsb_release=${DstName}"
	[ ! $(which wget) ] && _apt-get install -y wget

	if (( ! ${OffLine} )) ; then
		_echo "Enable the Puppet Labs Package Repository..."		
		wget https://apt.puppetlabs.com/puppetlabs-release-${DstName}.deb
		dpkg -i puppetlabs-release-${DstName}.deb
		rm puppetlabs-release-${DstName}.deb
	fi
	_apt-get update 
	_apt-get --yes install ${Package}
	_apt-get --yes --fix-broken install
	_apt-get --yes autoremove 

_echo "User ${DftUser} control..."
	if [ X"${DftUser}" == X"$(awk -F":" -v var=${DftUser} '{ if ($1 == var) print $1; }' /etc/passwd)" ] ; then
		_echo "User ${DftUser} is declared and will be the owner of this installation."
	else
		_echo "User ${DftUser} is not declared: Something went wrong."
		exit 1
	fi

_echo "Sourcing the directories of the configuration..."
	grep "dir=" ${confdir}/puppet.conf | while read Line
	do
		CfgDir=$(echo ${Line} | awk -F"=" '{print $2}')
		_echo "chown -R ${DftUser}:${DftUser} ${CfgDir}"
		eval chown -R ${DftUser}:${DftUser} ${CfgDir} 2>/dev/null
	done

_echo "Puppet $(puppet --version) is installed."

# End of the bootstrap
# The following part is the configuration of the modules and manifests for the project itself
. ./config-${Puppet}.sh

popd 2>/dev/null # pushd $(dirname $0)

_echo "Server $(hostname -f) ready."