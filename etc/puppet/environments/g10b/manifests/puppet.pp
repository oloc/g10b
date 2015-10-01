node 'puppet' {
  class {'g10b':}
  class {'g10b::ssh':}
  class {'g10b::app':}
}