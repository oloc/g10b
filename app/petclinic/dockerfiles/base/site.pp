$owner='mesos'
$group='mesos'
$host='karajan.oloc'

group { 'Mesos Group':
  ensure => present,
  name   => $group,
  before   => Class['mesos::slave'],
}

user { 'Mesos User':
  ensure  => present,
  name    => $owner,
  comment => 'mesos server',
  groups  => $group,
  home    => "/home/${owner}",
  before   => Class['mesos::slave'],
}

apt::source { 'mesosphere':
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
}

class { 'apt::update': }
class { 'mesos::slave':
  master  => $host,
  require => Class['apt::update'],
}