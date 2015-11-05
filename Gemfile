source "https://rubygems.org"

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.0.0','< 4.0']
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.1.0'
gem 'puppet-syntax'
gem 'rspec-puppet-facts', :require => false

gem 'puppet-lint', '~> 1.0'
gem 'rspec', '~> 3.0'
gem 'rspec-its', '~> 1.0'
gem 'rspec-collection_matchers', '~> 1.0'
gem 'metadata-json-lint'