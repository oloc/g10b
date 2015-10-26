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

  $packages= ['python-pip', 'python-pycurl', 'mongodb', 'python-pymongo']
  g10b::undef_package { $packages: }

  package { 'shinken':
    ensure  => latest,
    before  => File['/etc/shinken/shinken.cfg'],
    require => User[$user],
  }->
  exec{'/usr/bin/pip install shinken':
    unless  => "/bin/ls -l /usr/lib/python2.7/dist-packages/shinken",
    require => Package['python-pip','python-pycurl'],
  }
  exec{'/usr/bin/shinken install webui':
    unless  => "/usr/bin/shinken inventory | grep webui 2>/dev/null",
    require => Package['shinken'],
  }
  exec{'/usr/bin/shinken install auth-cfg-password':
    unless  => "/usr/bin/shinken inventory | grep auth-cfg-password 2>/dev/null",
    require => Package['shinken'],
  }

  file { '/etc/shinken/shinken.cfg':
    ensure => file,
    mode   => '0644',
  }
  file { '/etc/shinken/modules/webui.cfg':
    ensure => file,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/webui.cfg",
  }

  service{ 'shinken':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}