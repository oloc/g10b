class g10b::users {

  $admuser = hiera('admuser')
  $project = hiera('project')

  group { 'admin account group':
    ensure => present,
    name   => $admuser,
  }

  group { 'adm':
    ensure => present,
  }

  group { 'opt':
    ensure => present,
  }

  user { 'admin account':
    ensure   => present,
    name     => $admuser,
    comment  => 'admin account',
    groups   => [sudo, adm, opt],
    home     => "/home/${admuser}",
    password => '8f91640bb5850b0d7d49276cb5728f9e76fb1629',
    shell    => '/bin/bash',
  }
  
  file { 'admin home':
    ensure => directory,
    path   => "/home/${admuser}",
    group  => $admuser,
    mode   => '0640',
    owner  => $admuser,
  }

  file { 'bashrc':
    ensure => present,
    path   => "/home/${admuser}/.bashrc",
    group  => $admuser,
    mode   => '0644',
    owner  => $admuser,
    source => "puppet:///modules/${project}/bashrc",
  }

  file { 'bash_aliases':
    ensure => present,
    path   => "/home/${admuser}/.bash_aliases",
    group  => $admuser,
    mode   => '0644',
    owner  => $admuser,
    source => "puppet:///modules/${project}/bash_aliases",
  }

  file { 'profile':
    ensure => present,
    path   => "/home/${admuser}/.profile",
    group  => $admuser,
    mode   => '0644',
    owner  => $admuser,
    source => "puppet:///modules/${project}/profile",
  }

}
