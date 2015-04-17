node repositories {
	include ntp
	include g10b::users
	include g10b::files
	include g10b::cron

	class { 'git': }

	class { 'gitlab' : 
		puppet_manage_config => true,
		gitlab_branch        => '7.0.0',
		external_url         => "http://gitlab.$::domain",
		# admin@local.host
		# 5iveL!fe
	}

}