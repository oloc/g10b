define g10b::es_plugin (
  $name       = $title,
  $module_dir = undef,
  $instances  = 'es-01',
){
  include ::elasticsearch

  elasticsearch::plugin{$name:
    module_dir => $module_dir,
    instances  => $instances,
    require    => Class['elasticsearch'],
  }	
}