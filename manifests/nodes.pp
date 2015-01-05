node puppet {
	include g10b-node

	class {'mysql::server':
		root_password    => 'strongpassword',
		override_options => {
			users => {
	  			'someuser@localhost' => {
			    ensure                   => 'present',
			    max_connections_per_hour => '0',
			    max_queries_per_hour     => '0',
			    max_updates_per_hour     => '0',
			    max_user_connections     => '0',
			    password_hash            => '*F3A2A51A9B0F2BE2468926B4132313728C250DBF',
		  		},
			},
			grants => {
				'someuser@localhost/somedb.*' => {
				ensure     => 'present',
				options    => ['GRANT'],
				privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
				table      => 'somedb.*',
				user       => 'someuser@localhost',
				},
			},
			databases => {
				'somedb' => {
				ensure  => 'present',
				charset => 'utf8',
				},
			},
		}
	}

	class {'dashboard':
		dashboard_ensure          => 'present',
		dashboard_user            => 'puppet-dbuser',
		dashboard_group           => 'puppet-dbgroup',
		dashboard_password        => 'changeme',
		dashboard_db              => 'dashboard_prod',
		dashboard_charset         => 'utf8',
		dashboard_site            => $fqdn,
		dashboard_port            => '8080',
		mysql_root_pw             => 'changemetoo',
		passenger                 => true,
           }
}

node octopussy {
	include g10b-node
}
