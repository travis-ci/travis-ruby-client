require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:cucumber) 

RSpec::Core::RakeTask.new(:spec)

task :default => [:spec, :cucumber]
