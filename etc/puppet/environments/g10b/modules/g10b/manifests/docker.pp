class g10b::docker(
  $host = g10b::docker::host,
  $port = g10b::docker::port,
){
  class {'::docker':
	tcp_bind         => 'tcp://127.0.0.1:4243',
	extra_parameters => ["--insecure-registry ${host}.${::domain}:${port}"],
  }

}