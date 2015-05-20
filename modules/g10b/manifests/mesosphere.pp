class g10b_mesosphere {

	exec {'add_mesosphere-key':
		command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF",
		user    => 'root',
	}->
	exec {'add_mesosphere_repo':
		command => '/bin/echo "deb http://repos.mesosphere.io/$(lsb_release -is | tr \'[:upper:]\' \'[:lower:]\') $(lsb_release -cs) main" | \
				sudo /usr/bin/tee /etc/apt/sources.list.d/mesosphere.list',
		creates => "/etc/apt/sources.list.d/mesosphere.list",
		user    => 'root',
	}->
	exec {'/usr/bin/apt-get -y update':
		user => 'root',
	}->
	class { 'mesos::master': }

}