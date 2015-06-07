class g10b::rundeck {

  $rd_usr=hiera('rundeck::user')
  $rd_grp=hiera('rundeck::group')
  $rd_gsr=hiera('rundeck::grails_server_url')
  $rd_swc=hiera('rundeck::server_web_context')

  group { 'Rundeck Group':
    ensure => present,
    name   => $rd_grp,
  }

  user { 'Rundeck User':
    ensure  => present,
    name    => $rd_usr,
    comment => 'rundeck server',
    groups  => $rd_grp,
    home    => "/home/${rd_usr}",
  }

  exec { 'rundeck_service_stop':
    command => 'service rundeckd stop',
    user    => 'root',
  }->
  class { '::rundeck':
    user              => $rd_usr,
    group             => $rd_grp,
    jre_name          => 'openjdk-7-jre',
    grails_server_url => $rd_gsr,
    # waiting for https://github.com/puppet-community/puppet-rundeck/pull/92
    #server_web_context +> $rd_swc,
  }
}