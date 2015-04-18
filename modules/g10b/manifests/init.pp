class g10b {
	include '::ntp'
	include g10b::users
	include g10b::files
	include g10b::cron	

	$dnsservers = hiera('dnsclient::nameservers')
    $subnet = hiera('subnet')

	class { 'git': }

	class {'dnsclient':
		nameservers => "$dnsservers",
		domain => "$::domain",
	}

	network::route {'eth0':
		ipaddress => [ "10.0.2.0", ],
		netmask   => [ '255.255.255.0', ],
		gateway   => [ "*", ],
	}
	network::route {'eth1':
		ipaddress => [ "$subnet.0", ],
		netmask   => [ '255.255.255.0', ],
		gateway   => [ "$subnet.50", ],
	}
}
