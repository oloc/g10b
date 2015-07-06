class g10b(
  $admusr        = $g10b::admusr,
  $admgrp        = $g10b::admgrp,
  $subnet        = $g10b::subnet,
  $subadm        = $g10b::subadm,
  $dnsservers    = $g10b::dnsservers,
  $logstash_host = $logstash::host,
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
    servers => [$logstash::host],
  }

  class { 'apt::update': }
}
