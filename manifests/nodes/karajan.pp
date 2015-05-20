node karajan {
	class {'g10b':}
	class {'g10b::ssh':}
	class {'g10b::rundeck':}
	class {'g10b::mesosphere':}

	class { 'jenkins':
		config_hash => {
			'JENKINS_ARGS' => { 'value' => '--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX' }
		}
	}

}
