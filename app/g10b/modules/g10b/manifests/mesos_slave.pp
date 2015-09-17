class g10b::mesos_slave(
  $host = $g10b::mesos::host,
) inherits g10b::mesos {

  class { 'mesos::slave':
    master  => $host,
    require => Class['g10b::mesos'],
  }

}