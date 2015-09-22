class g10b::jenkins{

  class {'::jenkins':
    config_hash => { 'PREFIX' => { 'value' => '/jenkins' }, 'JENKINS_ARGS' => { 'value' => '--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --prefix=$PREFIX' } }
  }

  $plugins = hiera('jenkins::plugins')
  create_resources(jenkins::plugin, $plugins)

  file {'/var/lib/jenkins/hudson.tasks.Maven.xml':
    ensure  => present,
    source  => "puppet:///modules/${module_name}/hudson.tasks.Maven.xml",
  }
  file {'/var/lib/jenkins/org.jenkinsci.plugins.docker.commons.tools.DockerTool.xml':
    ensure  => present,
    source  => "puppet:///modules/${module_name}/org.jenkinsci.plugins.docker.commons.tools.DockerTool.xml",
  }
  file {'/var/lib/jenkins/org.jenkinsci.plugins.dockerbuildstep.DockerBuilder.xml':
    ensure => present,
    source => "puppet:///modules/${module_name}/org.jenkinsci.plugins.dockerbuildstep.DockerBuilder.xml",
  }
  
  $jobs = hiera('jenkins::jobs')
  create_resources("${module_name}::job", $jobs)

}