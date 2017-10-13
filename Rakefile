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

tags = ''#'--tag notifier '

if ENV['CAP_2_TEST'] == 'true'
  # tags += '--tag cap_2 '
else
  # tags += '--tag cap_3 '
end

if ENV['WITH_BUGSNAG'] == 'true'
  tags += '--tag with_notifier '
else
  tags += '--tag without_notifier '
end

RSpec::Core::RakeTask.new(:spec) do |opts|
  opts.rspec_opts = tags
end
task :default  => :spec
