node g10b-node {
	include g10b-users
	include ssh
}

node puppet.oloc inherits g10b-node{
	
}
