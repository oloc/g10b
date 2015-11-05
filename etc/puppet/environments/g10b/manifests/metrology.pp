node 'metrology' {
  class {'g10b':}
  class {'g10b::ssh':}

  class {'g10b::elk':}
  class {'shinken':}
}