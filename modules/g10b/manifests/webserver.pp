class webserver {

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
		{ 'path' => '/puppet',  'url' => "http://puppet.$::domain/"  },
		{ 'path' => '/rundeck', 'url' => "http://rundeck.$::domain:4440/" },
		{ 'path' => '/gitlab',  'url' => "http://gitlab.$::domain/"  },
		{ 'path' => '/jenkins', 'url' => "http://jenkins.$::domain:8080/" },
		],
	}
}
