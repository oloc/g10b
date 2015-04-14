class g10b::theforeman-dns {
    include ::dns

    $subnet = hiera('subnet')

    dns::zone { "$::domain":
        zonetype => 'master',
#        a =>    [{'name' => "gitlab.$::domain",  'ip' => "$subnet.57"},
#                 {'name' => "jenkins.$::domain", 'ip' => "$subnet.56"},
#                 {'name' => "rundeck.$::domain", 'ip' => "$subnet.56"}],
        masters => [ '8.8.8.8', '8.8.4.4' ],
        allow_transfer => [true],
    }
}