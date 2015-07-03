class g10b(
  $admusr     = $g10b::admusr,
  $admgrp     = $g10b::admgrp,
  $subnet     = $g10b::subnet,
  $subadm     = $g10b::subadm,
  $dnsservers = $g10b::dnsservers,
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
    require => Exec['apt-get_update'],
  }

  class {'::logstashforwarder':
    servers => [$logstash::host],
    require => Exec['elk::elasticsearch_add_key','elk::logstashforwarder_add_repo'],
  }

  exec {'apt-get_update':
    command => '/usr/bin/apt-get -y update',
    user    => 'root',
  }
}
