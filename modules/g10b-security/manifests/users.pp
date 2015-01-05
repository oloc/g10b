class g10b-security::users {

	$admuser='oloc'

	group { 'admin account group':
		name => $admuser,
 		ensure => 'present',
	}

	group { 'adm':
		ensure => 'present',
	}

	group { 'opt':
		ensure => 'present',
	}

	user { 'admin account':
		name => $admuser,
		ensure => 'present',
		groups => [sudo, adm, opt],
		home => "/home/$admuser",
		shell => '/bin/bash',
	}
	
	file { 'admin home':
		path => "/home/$admuser",
		ensure => directory ,
		group => $admuser,
		mode => 640,
		owner => $admuser,
	}

	file { 'bashrc':
		path => "/home/$admuser/.bashrc",
		ensure => 'present',
		group => $admuser,
		mode => 644,
		owner => $admuser,
		source => "puppet:///modules/g10b-security/bashrc",
	}

	file { 'bash_aliases':
		path => "/home/$admuser/.bash_aliases",
		ensure => 'present',
		group => $admuser,
		mode => 644,
		owner => $admuser,
		source => "puppet:///modules/g10b-security/bash_aliases",
	}

	file { 'profile':
		path => "/home/$admuser/.profile",
		ensure => 'present',
		group => $admuser,
		mode => 644,
		owner => $admuser,
		source => "puppet:///modules/g10b-security/profile",
	}

}
