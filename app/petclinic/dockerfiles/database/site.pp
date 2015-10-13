class {'::mysql::server':}

notify{"ipaddress=${::ipaddress}":}

mysql::db { 'petclinic':
  user           => 'myuser',
  password       => 'mypass',
  host           => $::ipaddress,
  grant          => ['SELECT', 'UPDATE'],
  sql            => '/root/initDB.sql',
  import_timeout => 900,
  require        =>  Class['mysql::server'],
}