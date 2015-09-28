class g10b::mesos_master(
  $port  = $g10b::mesos::port,
  $owner = $g10b::mesos::owner,
  $group = $g10b::mesos::group,
) inherits g10b::mesos {

  class { 'mesos::master':
    master_port => $port,
    owner       => $owner,
    group       => $group,
    require     => Class['g10b::mesos'],
  }

}