node puppet {
	include g10b-node

	$dashboard_user = pp-dbuser
	$dashboard_group = pp-dbgroup
	$dashboard_db = dashboard_prod

	class {'mysql::server':
		root_password    => 'strongpassword',
		override_options => {
			users => {
	  			"$dashboard_user@localhost" => {
			    ensure                   => 'present',
			    max_connections_per_hour => '0',
			    max_queries_per_hour     => '0',
			    max_updates_per_hour     => '0',
			    max_user_connections     => '0',
			    password_hash            => '*F3A2A51A9B0F2BE2468926B4132313728C250DBF',
		  		},
			},
			grants => {
				"$dashboard_user@localhost/$dashboard_db.*" => {
				ensure     => 'present',
				options    => ['GRANT'],
				privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
				table      => "$dashboard_db.*",
				user       => "$dashboard_user@localhost",
				},
			},
			databases => {
				"$dashboard_db" => {
				ensure  => 'present',
				charset => 'utf8',
				host => 'localhost',
				},
			},
		}
	}

	class {'dashboard':
		dashboard_ensure          => 'present',
		dashboard_user            => $dashboard_user,
		dashboard_group           => $dashboard_group,
		dashboard_password        => 'changeme',
		dashboard_db              => $dashboard_db,
		dashboard_charset         => 'utf8',
		dashboard_site            => $fqdn,
		dashboard_port            => '8080',
		mysql_root_pw             => 'strongpassword',
		passenger                 => true,
           }
}

node octopussy {
	include g10b-node
}
