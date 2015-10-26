define g10b::undef_package (
    $package_name = $title,
){
  if !defined(Package[$package_name]) {
    package { $package_name:
      ensure => present,
    }
  }
}