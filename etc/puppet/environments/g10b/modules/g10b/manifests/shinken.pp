class g10b::shinken(
  $user  = g10b::shinken::user,
  $group = g10b::shinken::group,
){

  group {'shinken group':
    ensure => present,
    name   => $group,
  }
  user {'shinken account':
    ensure => present,
    name   => $user,
    groups => $group,
  }

  $dirs=['/etc/shinken','/var/lib/shinken','/var/log/shinken','/var/run/shinken']
  file {$dirs:
    ensure => directory,
    mode   => '0755',
    owner  => $user,
    group  => $group,
  }

  $packages = hiera('shinken::packages')
  g10b::undef_package { $packages: }

  exec{'shinken_install_init':
    command => '/usr/bin/pip install shinken==2.4 && /usr/bin/shinken --init'
    unless  => '/bin/ls -l /usr/lib/python2.7/dist-packages/shinken',
    require => Package['python-pip','python-pycurl'],
  }
  
  $modules = hiera('shinken::modules')
  g10b::shinken_mod {$modules:
    require => Exec['shinken_install_init'],
  }

  file { '/etc/shinken/shinken.cfg':
    ensure => file,
    mode   => '0644',
  }
  file { '/etc/shinken/modules/webui2.cfg':
    ensure => file,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/webui2.cfg",
  }

  service{ 'shinken':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}