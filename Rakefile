# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'
begin
  Bundler.setup(:default)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bugsnag-capistrano #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# RSpec tasks
require 'rspec/core'
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:cap_3_test) do |opts|
  opts.rspec_opts = "--tag cap_3"
end

RSpec::Core::RakeTask.new(:cap_2_test) do |opts|
  opts.rspec_opts = "--tag cap_2"
end

task :default  => ENV['CAP_2_TEST'] == 'true' ? :cap_2_test : :cap_3_test
