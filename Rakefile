require 'rake'
require 'rspec/core/rake_task'

task :default => :test

desc "Runs the tests"
RSpec::Core::RakeTask.new(:test) do |spec|
  spec.pattern = 'spec/test/*_spec.rb'
  spec.rspec_opts = ['--tag ~logged_issues', '--backtrace', '--format documentation']
end