$override_options = {
  mysqld => {
    bind-address => undef,
  },
  mysqld_safe => {
    log-error => '/var/log/mysql/error.log',
    nice      => 0,
    pid-file  => '/var/run/mysqld/mysqld.pid',
    socket    => '/var/run/mysqld/mysqld.sock',    
  },
}

class {'::mysql::server':
  override_options => $override_options,
}

notify{"ipaddress=${::ipaddress}":}

# Ugly workaround to be sure mysql service is started
exec{'/usr/sbin/service mysql start':
  require        =>  Class['mysql::server'],
}->
mysql::db { 'petclinic':
  user           => 'myuser',
  password       => 'mypass',
  host           => '%',
  grant          => ['SELECT', 'UPDATE'],
  sql            => '/root/initDB.sql',
  import_timeout => 900,
}->
exec{'/usr/sbin/service mysql restart':
  require        =>  Class['mysql::server'],
}