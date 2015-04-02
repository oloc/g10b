node octopussy {
	include g10b

	class  { 'apache': }

    file { '/var/www/g10b/':
            ensure => directory,
            group => "root",
            mode => 775,
            owner => "root",
    }

    file { 'index':
    	ensure => file,
    	mode   => 640,
    	path   => "/var/www/g10b/index.html",
    	source => "puppet:///modules/g10b/index.html",
    }

	apache::vhost { 'g10b.oloc':
		docroot    => '/var/www/g10b/',
		proxy_pass => [
		{ 'path' => '/puppet',  'url' => 'http://puppet.oloc/'  },
		{ 'path' => '/rundeck', 'url' => 'http://rundeck.oloc:4440/' },
		{ 'path' => '/gitlab',  'url' => 'http://gitlab.oloc/'  },
		{ 'path' => '/jenkins', 'url' => 'http://jenkins.oloc:8080/' },
		],
	}
}
