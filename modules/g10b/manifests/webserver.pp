class g10b::webserver(
  $project = $g10b::project,
  $pass    = $pass,
){

  class  { 'apache': }

  file { 'index':
    ensure => file,
    mode   => '0644',
    path   => "/var/www/${project}/index.html",
    source => "puppet:///modules/${module_name}/index.html",
  }

  apache::vhost { "${project}.${::domain}":
    docroot       => "/var/www/${project}/",
    docroot_owner => 'root',
    docroot_group => 'root',
    docroot_mode  => '0775',
    proxy_pass    => $pass,
  }
  
}
