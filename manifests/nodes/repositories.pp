node repositories {
	include g10b
	include docker_registry

	class { 'gitlab' : 
		puppet_manage_config => true,
		gitlab_branch        => '7.0.0',
		external_url         => "http://gitlab.$::domain",
		# admin@local.host
		# 5iveL!fe
	}

}