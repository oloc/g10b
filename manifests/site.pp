filebucket { main: server => "puppet" }
File { backup => main }

Exec { path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" }

$mysql_password = "myT0pS3cretPa55worD"
