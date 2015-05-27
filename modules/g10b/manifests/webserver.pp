class g10b::webserver {
  $project = hiera('project')
  $pass = hiera('pass')

  class  { 'apache': }

# Duplicate declaration modules/apache/manifests/vhost.pp:261
#  file { "/var/www/${project}/":
#    ensure => directory,
#    group  => 'root',
#    mode   => '0775',
#    owner  => 'root',
#  }

  file { 'index':
    ensure => file,
    mode   => '0644',
    path   => "/var/www/${project}/index.html",
    source => "puppet:///modules/${project}/index.html",
  }

  apache::vhost { "${project}.${::domain}":
    docroot    => "/var/www/${project}/",
    proxy_pass => $pass,
  }
}
