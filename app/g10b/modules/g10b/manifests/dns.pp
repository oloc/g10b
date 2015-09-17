class g10b::dns(
    $subnet     = $g10b::subnet,
    $project    = $module_name,
    $forwarders = $g10b::dns::forwarders,
){
  # ajjahn-dns
  class {'dns::server':
    require => Class['apt::update'],
  }

  # Forward Zone
  dns::zone { $::domain:
    soa         => $::fqdn,
    soa_email   => "root.${::fqdn}",
    nameservers => [ $::fqdn ],
  }
  # Reverse Zone
  dns::zone { '10.168.192.IN-ADDR.ARPA':
    soa         => $::fqdn,
    soa_email   => "root.${::fqdn}",
    nameservers => [ $::fqdn ],
  }

  dns::server::options { '/etc/bind/named.conf.options':
    forwarders      => $forwarders,
    allow_recursion => [ 'any' ],
  }

  dns::record::a {
    $::hostname:
      zone => $::domain,
      data => [ $::ipaddress_eth1 ];
    'karajan':
      zone => $::domain,
      data => ["${subnet}.56"];
    'repositories':
      zone => $::domain,
      data => ["${subnet}.57"];
    'metrology':
      zone => $::domain,
      data => ["${subnet}.58"];
  }
  dns::record::cname {
    $project:
      zone => $::domain,
      data => "${::hostname}.${::domain}";
    'jenkins':
      zone => $::domain,
      data => "karajan.${::domain}";
    'rundeck':
      zone => $::domain,
      data => "karajan.${::domain}";
    'gitlab':
      zone => $::domain,
      data => "repositories.${::domain}";
  }
}