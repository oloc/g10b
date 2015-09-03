class g10b::elk(
  $kibana_user        = $g10b::elk::kibana_user,
  $kibana_group       = $g10b::elk::kibana_group,
  $kibana_port        = $g10b::elk::kibana_port,
  $elasticsearch_port = $g10b::elk::elasticsearch_port,
) {

  class {'elasticsearch':
    manage_repo  => true,
    repo_version => '2.0',
  }
  elasticsearch::instance { 'es-01':
    ensure  => present,
    require => Class['elasticsearch'],
  }
  elasticsearch::plugin{'mobz/elasticsearch-head':
    module_dir => 'head',
    instances  => 'es-01',
    require    => Class['elasticsearch'],
  }
  elasticsearch::plugin{'lukas-vlcek/bigdesk':
    module_dir => 'bigdesk',
    instances  => 'es-01',
    require    => Class['elasticsearch'],
  }

  class {'::logstash':
    manage_repo  => true,
    repo_version => '1.5',
    require      => File ['/etc/pki/tls/private']
  }

  logstash::configfile {'logstash-input.conf':
    source => "puppet:///modules/${module_name}/logstash-input.conf",
    order  => 01,
  }
  logstash::configfile {'logstash-syslog.conf':
    source => "puppet:///modules/${module_name}/logstash-syslog.conf",
    order  => 50,
  }
  logstash::configfile {'logstash-apache.conf':
    source => "puppet:///modules/${module_name}/logstash-apache.conf",
    order  => 50,
  }
  logstash::configfile {'logstash-output.conf':
    source => "puppet:///modules/${module_name}/logstash-output.conf",
    order  => 99,
  }

  class {'::kibana4':
    manage_user       => true,
    kibana4_user      => $kibana_user,
    kibana4_group     => $kibana_group,
    port              => $kibana_port,
    elasticsearch_url => "http://${::fqdn}:${elasticsearch_port}",
  }
}