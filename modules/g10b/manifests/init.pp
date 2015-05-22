class g10b {
  $dnsservers = hiera('dnsclient::nameservers')

  class {'g10b::users':}
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
