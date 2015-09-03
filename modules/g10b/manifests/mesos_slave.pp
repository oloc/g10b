class g10b::mesos_slave(
  $mesos_host = $g10b::mesos_host,
){

  class { 'mesos::slave':
    master  => $mesos_host,
    require => Class['g10b::mesos'],
  }

}