#!/bin/bash 

if [ $UID != 0 ] ; then
	echo "Please use sudo or root account."
	exit
fi

pushd $(pwd)/$(dirname $0) 2>/dev/null
. ./install.cfg
. ./install.lib

while getopts "ub:" Option
do
	case ${Option} in
	u|U) typeset -i Update=1 ;;
	b|B) typeset Branch="-b $OPTARG" ;;
	esac
done
shift $(($OPTIND - 1))


_echo "Puppet configuration for the ${ProjectName} project..."
pushd $(pwd)/..
if [ ${Update} ] ; then
	_echo "Update in progress..."
	env GIT_SSL_NO_VERIFY=true git pull ${Branch}
fi

_echo "Importing configuration..."
	cp ./etc/* ${confdir}/ | tee -a ${LogFile}
	echo "*.$(hostname -d)" >> ${confdir}/autosign.conf

_echo "Adding some modules..."
	grep -v '^#' modules.lst |
	while read Module
	do
		_echo "puppet module install ${Module}"
		(( ! ${OffLine} )) && puppet module install ${Module} | tee -a ${LogFile}
	done

	for Thingy in modules manifests hieradata
	do
		_echo "Importing ${ProjectName} ${Thingy}..."
		mkdir -p ${confdir}/${Thingy}/                        | tee -a ${logfile}
		cp -Rv ./${Thingy}/* ${confdir}/${Thingy}/            | tee -a ${LogFile}
		chown -R ${DftUser}:${DftUser} ${confdir}/${Thingy}   | tee -a ${LogFIle}
	done

popd # pushd $(pwd)/..
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
