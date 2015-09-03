class g10b::mesos(
  $mesos_owner = $g10b::mesos_owner,
  $mesos_group = $g10b::mesos_group,
){

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