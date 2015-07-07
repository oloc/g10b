class g10b::elk(
  $kibana_user        = $g10b::elk::kibana_user,
  $kibana_group       = $g10b::elk::kibana_group,
  $kibana_port        = $g10b::elk::kibana_port,
  $elasticsearch_port = $g10b::elk::elasticsearch_port,
) {

  class {'elasticsearch':}
  elasticsearch::instance { 'es-01':
    ensure  => present,
    require => Class['elasticsearch'],
  }
  
  class {'::logstash':}

  class {'::kibana4':
    manage_user       => true,
    kibana4_user      => $kibana_user,
    kibana4_group     => $kibana_group,
    host              => $::fqdn,
    port              => $kibana_port,
    elasticsearch_url => "http://${::fqdn}:${elasticsearch_port}",
  }
}