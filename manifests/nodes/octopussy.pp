node octopussy {
	include g10b

	class  { 'apache': }

	apache::vhost { 'g10b.oloc':
		proxy_pass => [
		{ 'path' => '/puppet',  'url' => 'http://puppet.oloc/'  },
		{ 'path' => '/rundeck', 'url' => 'http://rundeck.oloc:4440/' },
		{ 'path' => '/gitlab',  'url' => 'http://gitlab.oloc/'  },
		{ 'path' => '/jenkins', 'url' => 'http://jenkins.oloc:8080/' },
		],
	}
}
