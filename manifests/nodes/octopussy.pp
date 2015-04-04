node octopussy {
	include g10b
    include dns::server

    $Subnet = '192.168.10'

    dns::server::options { '/etc/bind/named.conf.options':
        forwarders => [ '8.8.8.8', '8.8.4.4' ]
    }
    dns::record::a {
        'gitlab':
            zone => 'gitlab.oloc',
            data => ["$Subnet.57"];
        'jenkins':
            zone => 'jenkins.oloc',
            data => ["$Subnet.56"];
        'rundeck':
            zone => 'rundeck.oloc',
            data => ["$Subnet.56"];
    }

	class  { 'apache': }

    file { '/var/www/g10b/':
            ensure => directory,
            group => "root",
            mode => 775,
            owner => "root",
    }

    file { 'index':
    	ensure => file,
    	mode   => 644,
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
