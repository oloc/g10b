class g10b::webserver {
  $project = hiera('project')
  $jk_port = hiera('jenkins::port')
  $gl_port = hiera('gitlab::port')
  $ms_port = hiera('mesos::master_port')
  $pp_port = '8140'
  $rd_port = hiera('rundeck::port')

  class  { 'apache': }

  file { "/var/www/${project}/":
    ensure => directory,
    group  => 'root',
    mode   => '0775',
    owner  => 'root',
  }

  file { 'index':
    ensure => file,
    mode   => '0644',
    path   => "/var/www/${project}/index.html",
    source => "puppet:///modules/${project}/index.html",
  }

  apache::vhost { "${project}.${::domain}":
    docroot    => "/var/www/${project}/",
    proxy_pass => [ 
      { " 'path' => '/puppet',  'url' => http://puppet.${::domain}:${pp_port}/ "},
      { " 'path' => '/rundeck', 'url' => http://karajan.${::domain}:${rd_port}/ "},
      { " 'path' => '/gitlab',  'url' => http://repositories.${::domain}:${gl_port}/gitlab "},
      { " 'path' => '/jenkins', 'url' => http://karajan.${::domain}:${jk_port}/jenkins "},
      { " 'path' => '/mesos',   'url' => http://karajan.${::domain}:${ms_port}/ "},
    ],
  }
}
