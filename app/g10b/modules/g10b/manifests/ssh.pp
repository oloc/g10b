class g10b::ssh{
  package { 'openssh-server':
    ensure => latest,
    before => File['/etc/ssh/sshd_config'],
  }

  file { '/etc/ssh/sshd_config':
    ensure => file,
    mode   => '0644',
  }

  service{ 'ssh':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }

}
