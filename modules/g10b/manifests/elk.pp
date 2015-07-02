class g10b::elk(
  $kb_usr  = kibana::user,
  $kb_grp  = kibana::group,
  $es_port = es::port,
){

  class {'elasticsearch':}
  class {'logstash':}
  class {'::kibana4':
    manage_user       => true,
    kibana4_user      => $kb_usr,
    kibana4_group     => $kb_grp,
    elasticsearch_url => "http://${::fqdn}:${es_port}",
  }
}