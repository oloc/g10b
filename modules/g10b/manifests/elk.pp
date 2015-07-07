class g10b::elk(
  $kibana_user        = $elk::kibana_user,
  $kibana_group       = $elk::kibana_group,
  $elasticsearch_port = $elk::elasticsearch_port,
) {

  class {'::elasticsearch':}
  class {'::logstash':}

  class {'::kibana4':
    manage_user       => true,
    kibana4_user      => $kibana_user,
    kibana4_group     => $kibana_group,
    elasticsearch_url => "http://${::fqdn}:${elasticsearch_port}",
  }
}