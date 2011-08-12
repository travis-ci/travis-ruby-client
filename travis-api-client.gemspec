Gem::Specification.new do |gem|

  gem.name = 'travis-client'
  gem.version = '0.1.0'
  gem.date = '2011-08-16'
  gem.authors = ['Roberto Decurnex']
  gem.email = 'nex.development@gmail.com'
  gem.description = %q{A Ruby wrapper for the Travis CI API}
  gem.summary = %q{A Ruby wrapper for the Travis CI API}
  gem.homepage = 'https://github.com/travis/travis-ruby-client'

  gem.add_runtime_dependency 'faraday'
  gem.add_runtime_dependency 'hirb'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'

  gem.required_ruby_version = '>= 1.8.7'

  gem.require_paths = ['lib']
  gem.files = `git ls-files`.split("\n")
  gem.bindir = 'bin'
  gem.executables = ['travis']

end

