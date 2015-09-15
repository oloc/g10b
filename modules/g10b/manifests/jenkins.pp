class g10b::jenkins{

  class {'::jenkins':
    config_hash => { 'JENKINS_ARGS' => { 'value' => '--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX' } }
  }

  $plugins  = hiera('jenkins::plugins')
  create_resources(jenkins::plugin, $plugins)

}