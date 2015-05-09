node karajan {
	include g10b
	include g10b::ssh

	$rd_usr='rundeck'
	$rd_grp='rundeck'

	class { 'jenkins': }
	
	# Mesosphere
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

	# Rundeck
	group { 'Rundeck Group':
		name => $rd_grp,
		ensure => 'present',
	}

	user { 'Rundeck User':
		name    => $rd_usr,
		ensure  => present,
		comment => 'rundeck server',
		groups  => $rd_grp,
		home    => "/home/$rd_usr",
	}

	exec { 'service rundeckd stop':
		user => 'root',
	}->
	class { 'rundeck':
		user  => $rd_usr,
		group => $rd_grp,
		# I have to force the jre because the default in rundeck::params is not appropriate.
		jre_name    => 'openjdk-7-jre',
		#jre_version => '7u71-2.5.3-0ubuntu0.14.04.1'
	}

}
