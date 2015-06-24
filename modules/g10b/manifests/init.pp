class g10b(
  $admusr     = $g10b::admusr,
  $admgrp     = $g10b::admgrp,
  $dnsservers = $g10b::dnsservers,
){

  class {'g10b::users':
    admusr => $admusr,
    admgrp => $admgrp,
  }
  class {'g10b::files':}
  class {'g10b::cron':}
  #class {'g10b::route':}

  class { '::git': }

  class {'dnsclient':
    nameservers => $dnsservers,
    domain      => $::domain,
  }

  class { '::ntp':
    require => Exec['apt-get_update'],
  }

  exec {'apt-get_update':
    command => '/usr/bin/apt-get -y update',
    user    => 'root',
  }
}
