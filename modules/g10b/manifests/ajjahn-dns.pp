class g10b::ajjahn-dns {
    include dns::server

    $subnet = hiera('subnet')

    dns::zone { "$::domain":
        soa => "$::fqdn",
    }

    dns::server::options { '/etc/bind/named.conf.options':
        forwarders => [ '8.8.8.8', '8.8.4.4' ]
    }

    dns::record::a {
        'gitlab':
            zone => "gitlab.$::domain",
            data => ["$subnet.57"];
        'jenkins':
            zone => "jenkins.$::domain",
            data => ["$subnet.56"];
        'rundeck':
            zone => "rundeck.$::domain",
            data => ["$subnet.56"];
    }

}