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

  $crt_dir = '/etc/pki/tls/certs'
  file {"${crt_dir}/${::domain}.crt":
    ensure => present,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/${::domain}.crt",
  }
  file {"${crt_dir}/${::domain}.key":
    ensure => present,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/${::domain}.key",
  }->
  file {"/etc/pki/tls/private/${::domain}.key":
    ensure => link,
    mode   => '0644',
    target => "${crt_dir}/${::domain}.key"
  }

}
