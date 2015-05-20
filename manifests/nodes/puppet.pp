node puppet {	
	$dshbrd_usr='dshbrd'
	$dshbrd_grp='dshgrp'
	$dshbrd_pwd='dshpwd'

	class {'g10b':}
	class {'g10b::ssh':}

	class { '::mysql::server':
		root_password => $mysql_password,
	}

}
