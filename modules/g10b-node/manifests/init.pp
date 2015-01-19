class g10b-node {
	include g10b-security
	include g10b-ssh
	include git
	include ntp

	cron { 'Puppet-Agent':
		command  => '/usr/bin/puppet agent --onetime --no-daemonize --splay',
		user     => 'root',
		month    => '*',
		monthday => '*',
		hour     => '*',
		minute   => '05',
	}

	package { "logrotate":
		ensure => installed,
	}

	cron { 'logrotate':
		command  => '/usr/sbin/logrotate',
		user     => 'root',
		month    => '*',
		monthday => '*',
		hour     => '2',
		minute   => '0',
	}

}
