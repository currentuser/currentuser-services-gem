# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'currentuser-services'
  gem.homepage = 'http://github.com/currentuser/currentuser-services-gem'
  gem.license = 'MIT'
  gem.summary = %Q{Offsite sign up and sign in forms for Currentuser.io}
  gem.description = %Q{Offsite sign up and sign in forms for Currentuser.io}
  gem.email = 'TBD'
  gem.authors = ["eric-currentuser"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test
