#!/bin/bash 
set -e

_echo() {
	echo "$(date +%Y%m%d-%H%M%S) - $1" | tee -a ${LogFile}
}

if [ $UID != 0 ] ; then
	echo "Please use sudo or root account."
	exit
fi

pushd $(dirname $0)
. ./install.cfg

_echo "Configuration for the ${ProjectName} project..."

_echo "Importing configuration..."
cp ./etc/* ${confdir}/ | tee -a ${LogFile}

_echo "chown -R ${DftUser}:${DftUser} ${confdir}"
chown -R ${DftUser}:${DftUser} ${confdir}

popd

_echo "Starting Puppet Client..."
#puppet resource service puppet       ensure=running enable=true
sudo puppet agent --enable
#sudo puppet agent --verbose --test --waitforcert 5
sudo puppet resource cron puppet-agent ensure=present user=root minute='*/5' command='/usr/bin/puppet agent --onetime --no-daemonize --splay'
_echo "Puppet agent scheduled."
_echo "Puppet agent configuration of server $(hostname -f) is done."