class g10b::mesos_master(
  $mesos_port  = $g10b::mesos_port,
  $mesos_owner = $g10b::mesos_owner,
  $mesos_group = $g10b::mesos_group,
){

  class { 'mesos::master':
    master_port => $mesos_port,
    owner       => $mesos_owner,
    group       => $mesos_group,
    require     => Class['g10b::mesos'],
  }

}