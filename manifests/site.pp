filebucket { 'main': server => 'puppet' }
File { backup => main }

Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }

node default {
  @@dns::record::a { $::hostname:
    zone => $::domain,
    data => $::ipadress,
  }
}

# Import is deprecated since Puppet 3.5
# import 'nodes/*.pp'