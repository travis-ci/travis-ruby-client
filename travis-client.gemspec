$:.unshift File.expand_path('../lib', __FILE__)
require 'travis/client/version'

Gem::Specification.new('travis-client', Travis::Client::VERSION) do |s|
  s.author      = 'Travis CI GmbH'
  s.email       = 'support@travis-ci.com'
  s.homepage    = 'https://developer.travis-ci.org'
  s.summary     = 'Travis CI API client'
  s.description = 'Ruby client library for Travis CI API v3'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.3.0'

  s.executables = ['dpl']
  s.files       = Dir['{config/**/*,lib/**/*,[A-Z]*}']

  # run time dependencies
  s.add_dependency 'memoyze', '~> 0.0.1'
  s.add_dependency 'regstry', '~> 1.0.0'
  s.add_dependency 'http', '~> 4.2'
  s.add_dependency 'addressable', '~> 2.7'
end
