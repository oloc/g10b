group { 'opt':
	ensure => 'present',
}

user { 'admin account':
	name => 'oloc',
	ensure => 'present',
	groups => [sudo, adm, opt],
	home => '/home/oloc',
	uid => 1000,
}

file { 'admin home':
	path => '/home/oloc',
	ensure => 'directory' ,
	mode => 640,
	owner => 'oloc',
}
