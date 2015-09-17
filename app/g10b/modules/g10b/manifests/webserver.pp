class g10b::webserver(
  $project = $module_name,
  $pass    = $g10b::webserver::pass,
){

  class  { 'apache': }

  file { 'index':
    ensure  => file,
    mode    => '0644',
    path    => "/var/www/${project}/index.html",
    content => template('g10b/index.html.erb'),
  }

  apache::vhost { "${project}.${::domain}":
    docroot       => "/var/www/${project}/",
    docroot_owner => 'root',
    docroot_group => 'root',
    docroot_mode  => '0775',
    proxy_pass    => $pass,
  }
  
}
