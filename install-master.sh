#!/bin/bash 
set -e

_echo() {
	echo "$(date +%Y%m%d-%H%M%S) - $1" | tee -a ${LogFile}
}

pushd $(dirname $0)
_echo "Loading configuration..."
ProjectName=g10b
DftUser='puppet'
confdir='/etc/puppet'
LogFile=./install.${ProjectName}.$(date +%Y%m%d.%H%M%S).log

while getopts "o" Option
do
	case ${Option} in
	o|O) typeset -i Offline=1 ;;
	esac
done
shift $(($OPTIND - 1))

if [ $UID != 0 ] ; then
	echo "Please use sudo or root account."
	exit
fi

_echo "Boostraping Installation of Puppet..."
if [ ! ${Offline} ] ; then
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
	apt-get --yes install puppetmaster puppet
	apt-get --yes --fix-broken install
	apt-get --yes autoremove 
else
	_echo "Installation offline"
fi

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

_echo "Configuration for the ${ProjectName} project..."

_echo "Importing configuration..."
cp ./etc/* ${confdir}/ | tee -a ${LogFile}
echo "*.$(hostname -d)" >> ${confdir}/autosign.conf

_echo "Adding some modules..."
grep -v '^#' modules.lst |
while read Module
do
	_echo "puppet module install ${Module}"
	puppet module install ${Module}
done

for Thingy in modules manifests
do
	_echo "Importing ${ProjectName} ${Thingy}..."
	cp -Rv ./${Thingy}/* ${confdir}/${Thingy}/           | tee -a ${LogFile}
	chown -R ${DftUser}:${DftUser} ${confdir}/${Thingy}  | tee -a ${LogFIle}
done

popd

_echo "chown -R ${DftUser}:${DftUser} ${confdir}"
chown -R ${DftUser}:${DftUser} ${confdir}

_echo "Starting Puppet Client..."
puppet resource service puppet       ensure=running enable=true
_echo "Starting Puppet Server..."
puppet resource service puppetmaster ensure=running enable=true

_echo "Puppet is configuring itself..."
_echo "puppet apply ${confdir}/manifests --modulepath=${confdir}/modules"
  sudo puppet apply ${confdir}/manifests --modulepath=${confdir}/modules

_echo "Server $(hostname -f) ready."