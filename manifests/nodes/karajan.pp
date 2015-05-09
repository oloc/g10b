node karajan {
	include g10b
	include g10b::ssh

	class { 'jenkins': }
	class { 'g10b::mesosphere':}
	class { 'g10b::rundeck': }
}
