class g10b(
  $project       = $module_name,
  $subnet        = $g10b::subnet,
  $subadm        = $g10b::subadm,
  $dnsservers    = $g10b::dnsservers,
  $elk_host      = $g10b::elk_host,
  $logstash_port = $g10b::logstash_port,
){

  class {'g10b::users':}
  class {'g10b::files':}
  class {'g10b::cron':}
  #class {'g10b::route':
  #  subnet => $subnet,
  #  subadm => $subadm,
  #}

  class { '::git': }

  class {'dnsclient':
    nameservers => $dnsservers,
  }

  class { '::ntp':
    require => Class['apt::update'],
  }

  class {'g10b::mesos_slave':}

  class {'g10b::logstashforwarder':
    elk_host      => $elk_host,
    logstash_port => $logstash_port,
  }

  if !defined(Class['apt::update']) {
    class { '::apt::update': }
  }

}
