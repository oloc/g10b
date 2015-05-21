node repositories {	
	class {'g10b':}

	class {'docker_registry':}

	class { 'gitlab': 
		puppet_manage_config => true,
		gitlab_branch        => '7.0.0',
		external_url         => "http://$::fqdn/gitlab",
		# admin@local.host
		# 5iveL!fe
	}

}