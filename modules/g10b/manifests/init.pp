class g10b {
	$dnsservers = hiera('dnsclient::nameservers')

	class {'g10b::users':}
	class {'g10b::files':}
	class {'g10b::cron':}
	class {'g10b::ntp':}	
	#class {'g10b::route':}

	class { '::git': }

	class {'dnsclient':
		nameservers => $dnsservers,
		domain => "$::domain",
	}

}
