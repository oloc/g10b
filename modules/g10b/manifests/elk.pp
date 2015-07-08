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
  elasticsearch::plugin{'mobz/elasticsearch-head':
    module_dir => 'head',
    require    => Class['elasticsearch'],
  }
  elasticsearch::plugin{'lukas-vlcek/bigdesk':
    module_dir => 'bigdesk',
    require    => Class['elasticsearch'],
  }

  class {'::logstash':}

  file {'/etc/logstash/logstash-syslog.conf':
    ensure  => present,
    content => template('g10b/logstash-syslog.conf.erb'),
  }

  file {'/etc/logstash/logstash-apache.conf':
    ensure  => present,
    content => template('g10b/logstash-apache.conf.erb'),
  }


  class {'::kibana4':
    manage_user       => true,
    kibana4_user      => $kibana_user,
    kibana4_group     => $kibana_group,
    port              => $kibana_port,
    elasticsearch_url => "http://${::fqdn}:${elasticsearch_port}",
  }
}