node 'testing', 'production' {
	include g10b
	include g10b::ssh

	include 'docker'
}
