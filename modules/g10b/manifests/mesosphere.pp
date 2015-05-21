class g10b::mesosphere {

	$ms_usr=hiera('mesos::owner')
	$ms_grp=hiera('mesos::group')

	group { 'Mesos Group':
		name => $ms_grp,
		ensure => 'present',
	}

	user { 'Mesos User':
		name    => $ms_usr,
		ensure  => present,
		comment => 'mesos server',
		groups  => $ms_grp,
		home    => "/home/$ms_usr",
	}

	exec {'mesosphere_add_key':
		command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF",
		user    => 'root',
	}->
	exec {'mesosphere_add_repo':
		command => '/bin/echo "deb http://repos.mesosphere.io/$(lsb_release -is | tr \'[:upper:]\' \'[:lower:]\') $(lsb_release -cs) main" | \
				sudo /usr/bin/tee /etc/apt/sources.list.d/mesosphere.list',
		creates => "/etc/apt/sources.list.d/mesosphere.list",
		user    => 'root',
	}->
	class { 'mesos::master':
		require => Exec['apt-get_update'],
	}

}