class g10b(
  $project       = $module_name,
  $admusr        = $g10b::admusr,
  $admgrp        = $g10b::admgrp,
  $subnet        = $g10b::subnet,
  $subadm        = $g10b::subadm,
  $dnsservers    = $g10b::dnsservers,
  $elk_host      = $g10b::elk_host,
  $logstash_port = $g10b::logstash_port,
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
else {
  # enter puppet code
}
  class { '::ntp':
    require => Class['apt::update'],
  }

  $file_crt = '/etc/pki/tls/certs/logstash-forwarder.crt'
  file {$file_crt:
    path   => $file_crt,
    source => "puppet:///modules/${module_name}/logstash-forwarder.crt",
  }
  class {'::logstashforwarder':
    servers      => ["${elk_host}.${::domain}:${logstash_port}"],
    ssl_ca       => $file_crt,
    manage_repo  => true,
    require      => File[$file_crt],
  }
  logstashforwarder::file { 'syslog':
    paths   => [ '/var/log/syslog' ],
    fields  => { 'type' => 'syslog' },
    require => Class['::logstashforwarder'],
  }
  logstashforwarder::file { 'auth.log':
    paths   => [ '/var/log/auth.log' ],
    fields  => { 'type' => 'auth' },
    require => Class['::logstashforwarder'],
  }

  if !defined(Class['apt::update']) {
    class { 'apt::update': }
  }

}
