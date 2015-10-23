node 'repositories' {
  class {'g10b':}

  $registry = '/var/lib/docker/registry'

# To greedy for a personnal sources repository. I let it as an example.
#  class { 'gitlab':
#    puppet_manage_config => true,
#    gitlab_branch        => '7.0.0',
#    external_url         => "http://${::fqdn}/gitlab",
#    # admin@local.host
#    # 5iveL!fe
#  }

  class {'::docker':
    tcp_bind => 'tcp://127.0.0.1:4243',
  }

  docker::run{'docker_registry':
  image   => 'registry',
  ports   => ['5000:5000'],
  expose  => ['5000'],
  volumes => [$registry, '/var/log', '/etc/pki/tls:/certs'],
  env     => ['REGISTRY_HTTP_TLS_CERTIFICATE'="/certs/${::domain}.crt", 'REGISTRY_HTTP_TLS_KEY'="/certs/${::domain}.key"],
  require => File[$registry],
  }

  file{$registry:
    ensure => directory,
  }
}