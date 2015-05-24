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

_echo "Stoping Puppet..."
	service puppetmaster stop   | tee -a ${LogFile}
	service puppetmaster status | tee -a ${LogFile}

_echo "Puppet configuration for the ${ProjectName} project..."
pushd $(pwd)/..
if [ ${Update} ] ; then
	_echo "Update in progress..."
	env GIT_SSL_NO_VERIFY=true git pull ${Branch}
fi

_echo "Importing configuration..."
	cp ./etc/* ${confdir}/ | tee -a ${LogFile}
	echo "*.$(hostname -d)" >> ${confdir}/autosign.conf
	Env=$(puppet config print environment)
	mkdir -p ${EnvDir}/${Env} | tee -a ${LogFile}
	echo "manifest=$confdir/manifests/" > ${EnvDir}/${Env}/environment.conf
	chown -R ${DftUser}:${DftUser} ${EnvDir}

_echo "Removing old modules..."
	puppet module list --tree | awk -F" " '{print $2}' | grep '-' |
	while  read Module; do
		GrepResult=$(grep ${Module} modules.lst)
		if [ $? != 0 ] ; then
			(( ! ${OffLine} )) && puppet module uninstall ${Module} | tee -a ${LogFile}
		fi
	done
_echo "Adding some modules..."
	grep -v '^#' modules.lst |
	while read Module; do
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

_echo "Scheduling Puppet Agent..."
puppet resource cron puppet-agent ensure=present user=root minute='*/5' command='/usr/bin/puppet agent --onetime --no-daemonize --splay'

_echo "Starting Puppet Server..."
puppet resource service puppetmaster ensure=running enable=true

_echo "Puppet master configuration of server $(hostname -f) is done."
