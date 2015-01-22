node gitlab {
	include g10b-node
	#include g10b-mysql
	#include nginx

	$gitlab_dbname = 'gitlab'
	$gitlab_dbuser = 'gitlab'
	$gitlab_dbpwd  = $mysql_password

	#class {'gitlab_db':
	#	gitlab_dbname => $gitlab_dbname,
	#	gitlab_dbuser => $gitlab_dbuser,
	#	gitlab_dbpwd  => $gitlab_dbpwd,
	#}
	class { '::mysql::server':
    	root_password  =>  $mysql_password,
    	databases => { "$gitlab_dbname" => { ensure => 'present' } }
  	} ->
  	package { 'build-essential':
		name => 'build-essential',
		ensure => installed,
		} ->
	package { 'g++':
		name => 'g++',
		ensure => installed,
	} ->
	package { 'ruby1.9.3':
		name => 'ruby1.9.3',
		ensure => installed,
	} ->
	package { 'ruby-dev':
		name => 'ruby-dev',
		ensure => installed,
	} ->
	class { 'gitlab':
		git_user          => 'gitlab',
	    git_email         => 'notifs@foobar.fr',
	    git_comment       => 'GitLab',
	    gitlab_domain     => 'gitlab.oloc',
	    gitlab_dbtype     => 'mysql',
	    gitlab_dbname     => $gitlab_dbname,
	    gitlab_dbuser     => $gitlab_dbuser,
	    gitlab_dbpwd      => $gitlab_dbpwd,
	    ldap_enabled      => false,
	}

	#Class['gitlab_db'] -> Class['gitlab'] ->
	#file { '/etc/nginx/conf.d/default.conf':
	#	ensure => absent,
	#} ->
	#exec { '/usr/sbin/service nginx reload': }

}
