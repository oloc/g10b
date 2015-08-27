class g10b(
  $project       = $module_name,
  $admusr        = $g10b::admusr,
  $admgrp        = $g10b::admgrp,
  $subnet        = $g10b::subnet,
  $subadm        = $g10b::subadm,
  $dnsservers    = $g10b::dnsservers,
  $elk_host      = $g10b::elk_host,
  $logstash_port = $g10b::logstash_port,
  $mesos_host    = hiera('mesos::host'),
  $mesos_owner   = hiera('mesos::owner'),
  $mesos_group   = hiera('mesos::group'),
){

  class {'g10b::users':
    admusr      => $admusr,
    admgrp      => $admgrp,
    mesos_owner => $mesos_owner,
    mesos_group => $mesos_group,
  }

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

  class {'mesos::slave':
    master => $mesos_host,
  }

  class {'g10b::logstashforwarder':
    elk_host      => $elk_host,
    logstash_port => $logstash_port,
  }

  if !defined(Class['apt::update']) {
    class { 'apt::update': }
  }

}
