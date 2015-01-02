#!/bin/bash 
set -e

pushd $(dirname $0)
. $(basename $0).cfg

apt-get --yes purge puppetmaster puppet puppetmaster-common puppet-common
apt-get --yes purge puppetlabs-release
apt-get --yes autoremove

grep "dir=" ${confdir}/puppet.conf | while read Line
do
	eval rm -Rf $(echo ${Line} | awk -F"=" '{print $2}')
done

popd
rm -Rf $(dirname $0)
