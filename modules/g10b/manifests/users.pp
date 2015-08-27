class g10b::users(
  $admusr      = $g10b::admusr,
  $admgrp      = $g10b::admgrp,
  $mesos_owner = $mesos::owner,
  $mesos_group = $mesos::group,
){

  group { 'admin user account group':
    ensure => present,
    name   => $admusr,
  }

  group { 'admin group':
    ensure => present,
    name   => $admgrp,
  }

  group { 'opt':
    ensure => present,
  }

  user { 'admin user account':
    ensure   => present,
    name     => $admusr,
    comment  => 'admin user account',
    groups   => [sudo, $admgrp, opt],
    home     => "/home/${admusr}",
    password => '8f91640bb5850b0d7d49276cb5728f9e76fb1629',
    shell    => '/bin/bash',
  }
  
  file { 'admin user home':
    ensure => directory,
    path   => "/home/${admusr}",
    group  => $admusr,
    mode   => '0640',
    owner  => $admusr,
  }

  file { 'bashrc':
    ensure => present,
    path   => "/home/${admusr}/.bashrc",
    group  => $admusr,
    mode   => '0644',
    owner  => $admusr,
    source => "puppet:///modules/${module_name}/bashrc",
  }

  file { 'bash_aliases':
    ensure => present,
    path   => "/home/${admusr}/.bash_aliases",
    group  => $admusr,
    mode   => '0644',
    owner  => $admusr,
    source => "puppet:///modules/${module_name}/bash_aliases",
  }

  file { 'profile':
    ensure => present,
    path   => "/home/${admusr}/.profile",
    group  => $admusr,
    mode   => '0644',
    owner  => $admusr,
    source => "puppet:///modules/${module_name}/profile",
  }

  group { 'Mesos Group':
    ensure => present,
    name   => $mesos_group,
  }

  user { 'Mesos User':
    ensure  => present,
    name    => $mesos_owner,
    comment => 'mesos server',
    groups  => $mesos_group,
    home    => "/home/${mesos_owner}",
  }

}
