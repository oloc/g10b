node g10b-node {
	include g10b-users
	include ssh
	include ntp
}

node puppet.oloc inherits g10b-node{
	
}
