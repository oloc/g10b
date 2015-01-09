node gitlab {
	include g10b-node
	include mysql
	include nginx

	$gitlab_dbname = 'gitlab'
	$gitlab_dbuser = 'gitlab'
	$gitlab_dbpwd  = $mysql_password

	class {'gitlab_db':
		gitlab_dbname => $gitlab_dbname,
		gitlab_dbuser => $gitlab_dbuser,
		gitlab_dbpwd  => $gitlab_dbpwd,
	}

	class {'gitlab':
		git_user          => 'gitlab',
	    git_email         => 'notifs@foobar.fr',
	    git_comment       => 'GitLab',
	    gitlab_domain     => 'gitlab.foobar.fr',
	    gitlab_dbtype     => 'mysql',
	    gitlab_dbname     => $gitlab_dbname,
	    gitlab_dbuser     => $gitlab_dbuser,
	    gitlab_dbpwd      => $gitlab_dbpwd,
	    ldap_enabled      => false,
	}

	Class['gitlab_db'] -> Class['gitlab'] ->
	file { '/etc/nginx/conf.d/default.conf':
		ensure => absent,
	} ->
	exec { '/usr/sbin/service nginx reload': }

}
