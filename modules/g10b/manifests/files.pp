class g10b::files {

  file { '/opt':
    ensure => directory,
    group  => 'opt',
    mode   => '0775',
    owner  => 'root',
  }

  file { '/var/lib/puppet':
    ensure => directory,
    group  => 'puppet',
    owner  => 'puppet',
  }

  file { '/etc/hiera.yaml':
    ensure => link,
    target => '/etc/puppet/hiera.yaml'
  }

  $certs=['/etc/pki','/etc/pki/tls','/etc/pki/tls/certs','/etc/pki/tls/private']
  file {$certs:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

}