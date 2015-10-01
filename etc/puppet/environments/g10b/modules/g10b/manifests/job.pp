define g10b::job(
  $project      = $module_name,
  $application  = $module_name,
  $jobname      = $title,
  $description  = $title,
  $git_url      = undef,
  $git_branch   = 'master',
  $docker_image = undef,
  $triggers     = undef,
  $publishers   = undef,
  $concurrent   = undef,
  $template     = undef,
){
  include ::jenkins


  $docker_registry_host = hiera('docker_registry::host')
  jenkins::job {$jobname:
    config => template("${module_name}/${template}"),
  }

}