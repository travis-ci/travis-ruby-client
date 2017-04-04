$:.unshift File.expand_path('../lib', __FILE__)
require 'travis/client/version'

Gem::Specification.new('travis-client', Travis::Client::VERSION) do |s|
  s.author                = 'Travis CI GmbH'
  s.email                 = 'support@travis-ci.com'
  s.homepage              = 'https://developer.travis-ci.org'
  s.summary               = 'Travis CI API client'
  s.description           = 'Ruby client library for Travis CI API v3'
  s.license               = 'MIT'
  s.required_ruby_version = '>= 2.3.0'

  if File.exist? '.git'
    s.files                 = `git ls-files`.split("\n")
    s.test_files            = `git ls-files -- {test,spec,features}/*`.split("\n")
    s.executables           = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  end

  # run time dependencies
  s.add_dependency 'http',        '~> 2.1'
  s.add_dependency 'addressable', '~> 2.5'

  # development dependencies
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'rspec',     '~> 3.5'
end
