#!/bin/bash 
set -e

_echo() {
	echo "$(date +%Y%m%d-%H%M%S) - $1" | tee -a ${LogFile}
}

_usage(){
	echo "Usage: $(basename) <master | agent>\nPuppet master will be installed with the puppet agent."
	exit
}

if [ $UID != 0 ] ; then
	echo "Please use sudo or root account."
	exit
fi

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

pushd $(dirname $0)
./install.cfg

_echo "Boostraping Installation of Puppet..."
	_echo "Prerequisites installation..."
	apt-get install -y lsb-release
	DstName=$(lsb_release -c -s)
	_echo "lsb_release=${DstName}"
	apt-get install -y wget

	_echo "Enable the Puppet Labs Package Repository..."
	wget https://apt.puppetlabs.com/puppetlabs-release-${DstName}.deb
	dpkg -i puppetlabs-release-${DstName}.deb
	rm puppetlabs-release-${DstName}.deb
	apt-get update

	_echo "Clean-up potential old version of puppet and puppetmaster..."
	apt-get --yes purge puppetmaster puppet puppetmaster-common puppet-common
	apt-get --yes purge puppetlabs-release
	apt-get --yes autoremove 
	_echo "apt-get install ${Package}"
	apt-get --yes install ${Package}
	apt-get --yes --fix-broken install
	apt-get --yes autoremove 

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
./config-${Puppet}.sh

popd # pushd $(dirname $0)

_echo "Server $(hostname -f) ready."