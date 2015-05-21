class g10b::ntp {
	exec {'ntp_update':
		command => '/usr/bin/apt-get -y update',
		user    => 'root',
	}->
	class { '::ntp': }
}