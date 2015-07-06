class g10b::mesosphere(
  $mesos_usr  = $mesos::owner,
  $mesos_grp  = $mesos::group,
  $mesos_port = $mesos::port,
){

  group { 'Mesos Group':
    ensure => present,
    name   => $mesos_grp,
  }

  user { 'Mesos User':
    ensure  => present,
    name    => $mesos_usr,
    comment => 'mesos server',
    groups  => $mesos_grp,
    home    => "/home/${ms_usr}",
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
  }->
  class { 'mesos::master':
    master_port => $mesos_port, 
    require     => Class['apt::update'],
  }

}