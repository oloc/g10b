class g10b::elk(
  $kibana_user        = $kibana::user,
  $kibana_group       = $kibana::group,
  $elasticsearch_port = $elasticsearch::port,
){

  class {'elasticsearch':
    require => Exec['elasticsearch_add_key','elasticsearch_add_repo'],
  }
  class {'logstash':
    require => Exec['elasticsearch_add_key','logstash_add_repo'],
  }
  class {'::kibana4':
    manage_user       => true,
    kibana4_user      => $kibana_user,
    kibana4_group     => $kibana_group,
    elasticsearch_url => "http://${::fqdn}:${elasticsearch_port}",
  }

  exec {'elasticsearch_add_key':
    command => 'wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -',
    user    => 'root',
  }

  exec {'elasticsearch_add_repo':
    command => '/bin/echo "deb http://packages.elastic.co/elasticsearch/1.6/debian stable main" | \
        sudo /usr/bin/tee /etc/apt/sources.list.d/elasticsearch.list',
    creates => '/etc/apt/sources.list.d/elasticsearch.list',
    user    => 'root',
    before  => Exec['apt-get_update'],
  }

  exec {'logstash_add_repo':
    command => '/bin/echo "deb http://packages.elasticsearch.org/logstash/current/debian stable main" | \
        sudo /usr/bin/tee /etc/apt/sources.list.d/logstash.list',
    creates => '/etc/apt/sources.list.d/logstash.list',
    user    => 'root',
    before  => Exec['apt-get_update'],
  }

  exec {'logstashforwarder_add_repo':
    command => '/bin/echo "deb http://packages.elasticsearch.org/logstashforwarder/debian stable main" | \
        sudo /usr/bin/tee /etc/apt/sources.list.d/logstashforwarder.list',
    creates => '/etc/apt/sources.list.d/logstashforwarder.list',
    user    => 'root',
    before  => Exec['apt-get_update'],
  }

}