class g10b-users {

	$admuser='oloc'

	group { 'opt':
		ensure => 'present',
	}
	
	user { 'admin account':
		name => $admuser,
		ensure => 'present',
		groups => [sudo, adm, opt],
		home => "/home/$admuser",
	}
	
	file { 'admin home':
		path => "/home/$admuser",
		ensure => 'directory' ,
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
		source => "puppet:///modules/g10b-users/bashrc",
	}

	file { 'bash_aliases':
		path => "/home/$admuser/.bash_aliases",
		ensure => 'present',
		group => $admuser,
		mode => 644,
		owner => $admuser,
		source => "puppet:///modules/g10b-users/bash_aliases",
	}

	file { 'profile':
		path => "/home/$admuser/.profile",
		ensure => 'present',
		group => $admuser,
		mode => 644,
		owner => $admuser,
		source => "puppet:///modules/g10b-users/profile",
	}

}
