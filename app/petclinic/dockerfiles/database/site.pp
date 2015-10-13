class {'::mysql::server':}

notify{"ipaddress=${::ipaddress}":}

# Ugly workaround to be sure mysql service is started
exec{'/usr/sbin/service mysql start':
  require        =>  Class['mysql::server'],
}->
mysql::db { 'petclinic':
  user           => 'myuser',
  password       => 'mypass',
  host           => $::ipaddress,
  grant          => ['SELECT', 'UPDATE'],
  sql            => '/root/initDB.sql',
  import_timeout => 900,
}