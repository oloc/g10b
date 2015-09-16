class g10b::jenkins{

  class {'::jenkins':
    config_hash => { 'JENKINS_ARGS' => { 'value' => '--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX' } }
  }->
  file {'/var/lib/jenkins/hudson.tasks.Maven.xml':
    ensure => present,
    source => "puppet:///modules/${module_name}/hudson.tasks.Maven.xml",
  }

  $plugins  = hiera('jenkins::plugins')
  create_resources(jenkins::plugin, $plugins)

  jenkins::job {'petclinic-build':
    config => file("${module_name}/petclinic.xml"),
  }

}