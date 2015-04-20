node puppet {
	include g10b
	include g10b::ssh
	
	$dshbrd_usr='dshbrd'
	$dshbrd_grp='dshgrp'
	$dshbrd_pwd='dshpwd'


	class { '::mysql::server':
		root_password => $mysql_password,
	}

}
