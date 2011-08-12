Gem::Specification.new do |gem|

  gem.name = 'travis-api-client'
  gem.version = '0.1.0'
  gem.date = '2011-08-09'
  gem.authors = ["Roberto Decurnex"]
  gem.email = 'nex.development@gmail.com'
  gem.description = %q{A Ruby wrapper for the Travis CI API}
  gem.summary = %q{A Ruby wrapper for the Travis CI API}
  gem.homepage = 'https://github.com/travis/travis-ruby-client'

  gem.add_runtime_dependency 'faraday'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'

  gem.require_paths = ['lib']
  gem.files = `git ls-files`.split("\n")

end

