node repositories {
	include git
	include ntp
	include g10b::users
	include g10b::directories
	include g10b::cron

	class { 'gitlab' : 
		puppet_manage_config => true,
		gitlab_branch        => '7.0.0',
		external_url         => 'http://gitlab.oloc',
		# admin@local.host
		# 5iveL!fe
	}

}