class g10b(
  $project    = $g10b::project,
  $admusr     = $g10b::admusr,
  $admgrp     = $g10b::admgrp,
  $subnet     = $g10b::subnet,
  $subadm     = $g10b::subadm,
  $dnsservers = $g10b::dnsservers,
  $elk_host   = $g10b::elk::host,
){

  class {'g10b::users':
    admusr => $admusr,
    admgrp => $admgrp,
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
    domain      => $::domain,
  }

  class { '::ntp':
    require => Class['apt::update'],
  }

  class {'::logstashforwarder':
    servers => [$elk_host],
  }

  if !defined(Class['apt::update']) {
    class { 'apt::update': }
  }

}
