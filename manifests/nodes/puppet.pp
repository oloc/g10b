node puppet {
	include g10b-node
	#include g10b-mysql::mysql

	cron{ 'Puppet Apply':
		command => 'puppet apply $confdir/manifests --modulepath=$confdir/modules',
		user => 'puppet',
		minute => 10,
	}
}
