node 'octopussy' {
  class {'g10b':}
  class {'g10b::dns':}
  class {'g10b::ssh':}

  class {'g10b::webserver':
    project => hiera('g10b::project'),
  }

}