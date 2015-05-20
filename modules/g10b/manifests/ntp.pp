class g10b_ntp {
	exec {'/usr/bin/apt-get -y update':
		user => 'root',
	}->
	class { '::ntp': }
}