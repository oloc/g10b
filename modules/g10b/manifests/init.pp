class g10b {
	include git
	include ntp
	include g10b::users
	include g10b::directories
	include g10b::cron
	include g10b::ssh	
}
