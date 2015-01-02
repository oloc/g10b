node g10b-node {
	include g10b-users
	#include ssh
	#include ntp
}

node puppet inherits g10b-node{
	
}
