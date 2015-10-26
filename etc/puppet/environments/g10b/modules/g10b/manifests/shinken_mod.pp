define g10b::shinken_mod (
  $mod_name = $title,
){
  exec{"/usr/bin/shinken install ${mod_name}":
    unless  => "/usr/bin/shinken inventory | grep ${mod_name} 2>/dev/null",
  }
}