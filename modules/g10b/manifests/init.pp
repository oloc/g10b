class g10b {
	include g10b_users
	include g10b_files
	include g10b_cron
	include g10b_ntp	
	#include g10b_route

	$dnsservers = hiera('dnsclient::nameservers')

	class { 'git': }

	class {'dnsclient':
		nameservers => $dnsservers,
		domain => "$::domain",
	}

}
