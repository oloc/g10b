node puppet {
	include g10b-node
	include g10b-mysql::mysql

	cron{ 'Puppet Agent':
		command => 'puppet agent --verbose --test',
		user => 'puppet',
		minute => 10,
	}
}
