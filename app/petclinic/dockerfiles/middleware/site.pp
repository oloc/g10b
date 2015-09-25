class { 'tomcat': } ->
class { 'java': } ->

tomcat::instance { 'tomcat8':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  source_url    => 'http://mirrors.ircam.fr/pub/apache/tomcat/tomcat-8/v8.0.26/bin/apache-tomcat-8.0.26.tar.gz'
}->
tomcat::service { 'tomcat8':
  service_ensure => running,
  catalina_base  => '/opt/apache-tomcat/tomcat8',
}

tomcat::war { 'petclinic.war':
  catalina_base => '/opt/apache-tomcat/tomcat8/',
  war_source    => 'http://karajan.oloc:8080/jenkins/view/petclinic/job/petclinic-build/ws/target/petclinic.war',
}