class g10b::ntp {
	exec {'/usr/bin/apt-get -y update':
		user => 'root',
	}->
	class { '::ntp': }
}