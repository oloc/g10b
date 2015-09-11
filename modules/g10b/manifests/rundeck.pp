class g10b::rundeck(
  $user               = $g10b::rundeck::user,
  $group              = $g10b::rundeck::group,
  $grails_server_url  = $g10b::rundeck::grails_server_url,
  $server_web_context = $g10b::rundeck::server_web_context,
){

  group { 'Rundeck Group':
    ensure => present,
    name   => $group,
  }

  user { 'Rundeck User':
    ensure  => present,
    name    => $user,
    comment => 'rundeck server',
    groups  => $group,
    expiry  => absent,
    shell   => '/bin/false',
    home    => "/home/${user}",
  }

  exec { 'service_stop':
    command => 'service rundeckd stop',
    user    => 'root',
  }->
  class { '::rundeck':
    user               => $user,
    group              => $group,
    jre_name           => 'openjdk-7-jre',
    grails_server_url  => $grails_server_url,
    server_web_context => $server_web_context, # https://github.com/puppet-community/puppet-rundeck/pull/92
  }
}