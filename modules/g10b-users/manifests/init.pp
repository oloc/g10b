class g10b-users {

	admuser='oloc'

	group { 'opt':
		ensure => 'present',
	}
	
	user { 'admin account':
		name => $admuser,
		ensure => 'present',
		groups => [sudo, adm, opt],
		home => '/home/$admuser',
	}
	
	file { 'admin home':
		path => '/home/$admuser',
		ensure => 'directory' ,
		group => $admuser,
		mode => 640,
		owner => $admuser,
	}

	file { 'bashrc':
		path => '/home/$admuser/.bashrc',
		ensure => 'present',
		group => $admuser,
		mode => 644,
		owner => $admuser,
		source => "puppet:///g10b-users/bashrc",
	}

	file { 'profile':
		path => '/home/$admuser/.profile',
		ensure => 'present',
		group => $admuser,
		mode => 644,
		owner => $admuser,
		source => "puppet:///g10b-users/profile",
	}

}
