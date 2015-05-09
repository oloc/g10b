class g10b::route {
	
	$subnet = hiera('subnet')

	network::route {'eth0':
		ipaddress => [ "10.0.2.0", ],
		netmask   => [ '255.255.255.0', ],
		gateway   => [ "*", ],
	}
	network::route {'eth1':
		ipaddress => [ 'default', "$subnet.0", ],
		netmask   => [ '0.0.0.0', '255.255.255.0', ],
		gateway   => [ "$subnet.50", "$subnet.50", ],
	}
}