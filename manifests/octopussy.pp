node 'octopussy' {
  class {'g10b':}
  class {'g10b::dns':}
  class {'g10b::ssh':}

  class {'g10b::webserver':}

  class { 'wildfly': }

  $apache_fields = { 'type' => 'apache' }
  logstashforwarder::file { 'apache.log':
    paths  => [ '/var/log/apache2/*.log' ],
    fields => $apache_fields,
  }

}