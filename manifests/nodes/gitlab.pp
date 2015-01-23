node gitlab {
	include g10b-node

	class { 'gitlab' : 
		puppet_manage_config => true,
		gitlab_branch        => '7.0.0',
		external_url         => 'http://gitlab.oloc',
	}

}