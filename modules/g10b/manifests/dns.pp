class g10b::dns {
    # ajjahn-dns
    include dns::server

    $subnet = hiera('subnet')
    $project = hiera('project')

    # Forward Zone
    dns::zone { "$::domain":
        soa => "$::fqdn",
        nameservers => ["$::hostname"],
    }
    # Reverse Zone
    dns::zone { '10.168.192.IN-ADDR.ARPA':
        soa => "$::fqdn",
        nameservers => ["$::hostname"],
    }

    dns::server::options { '/etc/bind/named.conf.options':
        forwarders => [ '8.8.8.8', '8.8.4.4' ]
    }

    dns::record::a {
        "$::hostname":
            zone => "$::domain",
            data => ["$::ipaddress_eth1"];   
        'karajan':
            zone => "$::domain",
            data => ["$subnet.56"];
        'repositories':
            zone => "$::domain",
            data => ["$subnet.57"];
    }
    dns::record::cname {
        "$project":
            zone => "$::domain",
            data => "$::hostname.$::domain";
        'jenkins':
            zone => "$::domain",
            data => "karajan.$::domain";
        'rundeck':
            zone => "$::domain",
            data => "karajan.$::domain";
        'gitlab':
            zone => "$::domain",
            data => "repositories.$::domain";
    }
}