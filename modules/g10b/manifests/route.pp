class g10b_route {
	
	$subnet = hiera('subnet')
	$subadm = hiera('subadm')

	network::route {'eth0':
		ipaddress => [ "$subadm.0", ],
		netmask   => [ '255.255.255.0', ],
		gateway   => [ "*", ],
	}
	if $::ipaddress_eth2 {
		network::route {'eth1':
			ipaddress => [ "$subnet.0", ],
			netmask   => [ '255.255.255.0', ],
			gateway   => [ "$subnet.50", ],
		}
		network::route {'eth2':
			ipaddress => [ 'default', ],
			netmask   => [ '0.0.0.0', ],
			gateway   => [ "*" , ],
		}
	}
	else {
		network::route {'eth1':
			ipaddress => [ 'default', ],
			netmask   => [ '0.0.0.0', ],
			gateway   => [ "$subnet.50", ],
		}
	}
}