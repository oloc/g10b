#!/bin/bash 

if [ $UID != 0 ] ; then
	echo "Please use sudo or root account."
	exit
fi

pushd $(pwd)/$(dirname $0) 2>/dev/null
. ./install.cfg
. ./install.lib

while getopts "u" Option
do
	case ${Option} in
	u|U) typeset -i Update=1 ;;
	esac
done
shift $(($OPTIND - 1))


_echo "Puppet configuration for the ${ProjectName} project..."
FromDir="$(pwd)/.."
if [ ${Update} ] ; then
	_echo "Update in progress..."
	rm -Rf /tmp/${ProjectName} 2>/dev/null
	env GIT_SSL_NO_VERIFY=true git clone https://github.com/oloc/${ProjectName}.git /tmp/${ProjectName}
	FromDir=/tmp/${ProjectName}
fi
pushd ${FromDir}
_echo "Importing configuration..."
	cp ${FromDir}/etc/* ${confdir}/ | tee -a ${LogFile}
	echo "*.$(hostname -d)" >> ${confdir}/autosign.conf

_echo "Adding some modules..."
	grep -v '^#' modules.lst |
	while read Module
	do
		_echo "puppet module install ${Module}"
		(( ! ${OffLine} )) && puppet module install ${Module}
	done

	for Thingy in modules manifests
	do
		_echo "Importing ${ProjectName} ${Thingy}..."
		cp -Rv ${FromDir}/${Thingy}/* ${confdir}/${Thingy}/  | tee -a ${LogFile}
		chown -R ${DftUser}:${DftUser} ${confdir}/${Thingy}  | tee -a ${LogFIle}
	done

popd # pushd ${FromDir}
popd # pushd $(dirname $0)

_echo "chown -R ${DftUser}:${DftUser} ${confdir}"
chown -R ${DftUser}:${DftUser} ${confdir}

_echo "Starting Puppet Client..."
puppet resource service puppet       ensure=running enable=true
_echo "Starting Puppet Server..."
puppet resource service puppetmaster ensure=running enable=true

_echo "Puppet is configuring itself..."
_echo "puppet apply ${confdir}/manifests --modulepath=${confdir}/modules"
  sudo puppet apply ${confdir}/manifests --modulepath=${confdir}/modules

_echo "Puppet master configuration of server $(hostname -f) is done."