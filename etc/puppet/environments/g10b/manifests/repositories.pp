node 'repositories' {
  class {'g10b':}

  $registry = '/var/lib/docker/registry'

  class { 'gitlab':
    external_url => "http://${::fqdn}/gitlab",
  }

  class {'::docker':
    tcp_bind => 'tcp://127.0.0.1:4243',
  }

  docker::run{'docker_registry':
  image   => 'registry:2',
  ports   => ['5000:5000'],
  expose  => ['5000'],
  volumes => ['/var/lib:/var/lib/registry', '/var/log', '/etc/pki/tls/certs:/certs'],
  env     => ["REGISTRY_HTTP_TLS_CERTIFICATE=/certs/${::domain}.crt", "REGISTRY_HTTP_TLS_KEY=/certs/${::domain}.key"],
  require => File[$registry],
  }

  file{$registry:
    ensure => directory,
  }
}