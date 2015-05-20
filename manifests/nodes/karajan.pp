node karajan {
	include g10b
	include g10b_ssh
	include g10b_rundeck
	include g10b_mesosphere

	class { 'jenkins': }

}
