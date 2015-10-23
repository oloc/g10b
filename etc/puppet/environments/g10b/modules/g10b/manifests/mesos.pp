class g10b::mesos(
  $host  = $g10b::mesos::host,
  $port  = $g10b::mesos::port,
  $owner = $g10b::mesos::owner,
  $group = $g10b::mesos::group,
){

  group { 'Mesos Group':
    ensure => present,
    name   => $group,
  }

  user { 'Mesos User':
    ensure  => present,
    name    => $owner,
    comment => 'mesos server',
    groups  => $group,
    home    => "/home/${owner}",
  }

  apt::source { 'mesosphere':
    #location => "http://repos.mesosphere.io/${::lsbdistid}", - ${::lsbdistid} retrieve an Ubuntu instead of ubuntu.
    location => 'http://repos.mesosphere.io/ubuntu',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      'id'     => '81026D0004C44CF7EF55ADF8DF7D54CBE56151BF',
      'server' => 'keyserver.ubuntu.com',
    },
    include  => {
      'src' => false,
      'deb' => true,
    },
    before   => Class['apt::update'],
  }->
  class {'::mesos':
    ensure         => present,
    listen_address => $::ipaddress_eth1,
    use_syslog     => true,
  }

}