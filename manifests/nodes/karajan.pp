node karajan {
	include g10b
	include g10b::ssh

	$rd_usr='rundeck'
	$rd_grp='rundeck'

	class { 'jenkins': }

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

	class { 'rundeck':
		user  => $rd_usr,
		group => $rd_grp,
		# I have to force the jre because the default in rundeck::params is not appropriate.
		jre_name    => 'openjdk-7-jre',
		#jre_version => '7u71-2.5.3-0ubuntu0.14.04.1'
	}

}
