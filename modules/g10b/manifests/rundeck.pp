class g10b::rundeck(
  $user               = $g10b::rundeck::user,
  $group              = $g10b::rundeck::group,
  $grails_server_url  = $g10b::rundeck::grails_server_url,
  $server_web_context = $g10b::rundeck::server_web_context,
){

  class { '::rundeck':
    user               => $user,
    group              => $group,
    jre_name           => 'openjdk-7-jre',
    grails_server_url  => $grails_server_url,
    server_web_context => $server_web_context, # https://github.com/puppet-community/puppet-rundeck/pull/92
  }
}