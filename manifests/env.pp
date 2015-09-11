node 'testing', 'production' {
  class {'g10b':}
  class {'g10b::ssh':}

  class {'docker':}
}
