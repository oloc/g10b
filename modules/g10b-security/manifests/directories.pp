class g10b-security::directories {

        file { '/opt':
                ensure => directory,
                group => "opt",
                mode => 775,
                owner => "root",
        }

	file { '/var/lib/puppet':
		ensure => directory,
		group => 'puppet',
		owner => 'puppet',
	}
}
