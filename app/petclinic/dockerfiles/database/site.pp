class {'::mysql::server':}

mysql::db { 'petclinic':
  user     => 'myuser',
  password => 'mypass',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE'],
  sql      => '/root/initDB.sql',
  import_timeout => 900,
}