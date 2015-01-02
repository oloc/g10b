class g10b-ssh{
	package {"openssh-server":
		ensure => latest,
	}

	service{ g10b-ssh:
		ensure => running,
		hasrestart => true,
	}
}
