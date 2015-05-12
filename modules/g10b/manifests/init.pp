class g10b {
	include '::ntp'
	include g10b::users
	include g10b::files
	include g10b::cron	

	$dnsservers = hiera('dnsclient::nameservers')

	class { 'git': }

	class {'dnsclient':
		nameservers => $dnsservers,
		domain => "$::domain",
	}

	class { 'g10b::route': }

}
