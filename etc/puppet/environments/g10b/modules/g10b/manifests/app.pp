class g10b::app{

  $applications = hiera('applications')
  file {'/etc/puppet/hieradata/jenkins.yaml':
    ensure  => present,
    content => template("${module_name}/jenkins.yaml.erb"),
  }	

}