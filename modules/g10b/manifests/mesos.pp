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
    home    => "/home/${mesos_owner}",
  }

  exec {'mesosphere_add_key':
    command => '/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF',
    user    => 'root',
  }->
  exec {'mesosphere_add_repo':
    command => '/bin/echo "deb http://repos.mesosphere.io/$(lsb_release -is | tr \'[:upper:]\' \'[:lower:]\') $(lsb_release -cs) main" | \
        sudo /usr/bin/tee /etc/apt/sources.list.d/mesosphere.list',
    creates => '/etc/apt/sources.list.d/mesosphere.list',
    user    => 'root',
    before  => Class['apt::update'],
  }

}