node karajan {
	include g10b
	include g10b::ssh
	include g10b::rundeck
	include g10b::mesosphere

	class { 'jenkins': }

}
