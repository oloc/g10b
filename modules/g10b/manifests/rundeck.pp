class g10b::rundeck {

	$rd_usr=hiera('rundeck::user')
	$rd_grp=hiera('rundeck::group')

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

	exec { 'rundeck_service_stop':
		command => 'service rundeckd stop',
		user    => 'root',
	}->
	class { '::rundeck':
		user  => $rd_usr,
		group => $rd_grp,
		# I have to force the jre because the default in rundeck::params is not appropriate.
		jre_name    => 'openjdk-7-jre',
		#jre_version => '7u71-2.5.3-0ubuntu0.14.04.1'
	}
}