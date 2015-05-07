class g10b::webserver {

    $project = hiera('project')

    class  { 'apache': }

    file { "/var/www/$project/":
        ensure => directory,
        group => "root",
        mode => 775,
        owner => "root",
    }

    file { 'index':
        ensure => file,
        mode   => 644,
        path   => "/var/www/$project/index.html",
        source => "puppet:///modules/$project/index.html",
    }

	apache::vhost { "$project.$::domain":
		docroot    => "/var/www/$project/",
		proxy_pass => [
		{ 'path' => '/puppet',  'url' => "http://puppet.$::domain:8140/"  },
		{ 'path' => '/rundeck', 'url' => "http://karajan.$::domain:4440/" },
		{ 'path' => '/gitlab',  'url' => "http://repository.$::domain:80/"  },
		{ 'path' => '/jenkins', 'url' => "http://karajan.$::domain:8080/" },
        { 'path' => '/mesos',   'url' => "http://karajan.$::domain:80/" },
		],
	}
}
