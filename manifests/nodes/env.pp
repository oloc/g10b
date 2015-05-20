node 'testing', 'production' {
	class {'g10b':}
	class {'g10b_ssh':}

	class {'docker':}
}
