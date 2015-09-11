class g10b::logstashforwarder(
  $elk_host      = $g10b::elk_host,
  $logstash_port = $g10b::logstash_port,
){

  $file_crt = '/etc/pki/tls/certs/logstash-forwarder.crt'
  file {$file_crt:
    path   => $file_crt,
    source => "puppet:///modules/${module_name}/logstash-forwarder.crt",
  }
  $file_key = '/etc/pki/tls/certs/logstash-forwarder.key'
  file {$file_key:
    path   => $file_key,
    source => "puppet:///modules/${module_name}/logstash-forwarder.key",
  }

  class {'::logstashforwarder':
    servers     => ["${elk_host}.${::domain}:${logstash_port}"],
    ssl_ca      => $file_crt,
    manage_repo => true,
    require     => File[$file_crt,$file_key],
  }

  $syslog_fields = { 'type' => 'syslog' }
  logstashforwarder::file { 'syslog':
    paths  => [ '/var/log/syslog' ],
    fields => $syslog_fields,
  }
  $auth_fields = { 'type' => 'auth' }
  logstashforwarder::file { 'auth.log':
    paths  => [ '/var/log/auth.log' ],
    fields => $auth_fields,
  }

}