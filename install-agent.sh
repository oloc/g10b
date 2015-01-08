#!/bin/bash 
set -e

_echo() {
	echo "$(date +%Y%m%d-%H%M%S) - $1" | tee -a ${LogFile}
}

pushd $(dirname $0)
_echo "Loading configuration..."
DftUser='puppet'
confdir='/etc/puppet'
LogFile=./install.$(date +%Y%m%d.%H%M%S).log

if [ $UID != 0 ] ; then
	echo "Please use sudo or root account."
	exit
fi

_echo "Boostraping Installation of Puppet..."
_echo "Prerequisites installation..."
apt-get install -y lsb-release
DstName=$(lsb_release -c -s)
apt-get install -y wget

_echo "Enable the Puppet Labs Package Repository..."
wget https://apt.puppetlabs.com/puppetlabs-release-${DstName}.deb
dpkg -i puppetlabs-release-${DstName}.deb
rm puppetlabs-release-${DstName}.deb
apt-get update
	
apt-get --yes autoremove 
apt-get --yes install puppet
apt-get --yes --fix-broken install

_echo "User ${DftUser} control..."
if [ X"${DftUser}" == X"$(awk -F":" -v var=${DftUser} '{ if ($1 == var) print $1; }' /etc/passwd)" ] ; then
	echo "User ${DftUser} is declared and will be the owner of this installation."
else
	echo "User ${DftUser} is not declared: Something went wrong."
	exit 1
fi

_echo "Sourcing the directories of the configuration..."
grep "dir=" ${confdir}/puppet.conf | while read Line
do
	CfgDir=$(echo ${Line} | awk -F"=" '{print $2}')
	_echo "chown -R ${DftUser}:${DftUser} ${CfgDir}"
	chown -R ${DftUser}:${DftUser} ${CfgDir}
done

_echo "Puppet $(puppet --version) is installed."


popd

_echo "Starting Puppet Client..."
puppet resource service puppet       ensure=running enable=true
