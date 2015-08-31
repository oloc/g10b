class g10b::mesos(
  $port  = $g10b::mesos::port,
  $owner = $g10b::mesos::owner,
  $group = $g10b::mesos::group,
){

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
    master_port => $port,
    owner       => $owner,
    group       => $group,
    require     => Class['apt::update'],
  }

}