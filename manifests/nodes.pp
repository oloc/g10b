node puppet {
	include g10b-node
	include g10b-mysql
}

node octopussy {
	include g10b-node
}
