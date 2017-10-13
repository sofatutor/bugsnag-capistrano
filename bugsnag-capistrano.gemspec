Gem::Specification.new do |s|
  s.name = "bugsnag-capistrano"
  s.version = File.read("VERSION").strip

  s.authors = ["Keegan Lowenstein", "Martin Holman"]
  s.email = "keegan@bugsnag.com"

  s.summary = "Notify Bugsnag when deploying with Capistrano"
  s.description = "Correlate Capistrano deploys with new errors and increased error rates in Bugsnag"
  s.homepage = "http://github.com/bugsnag/bugsnag-capistrano"
  s.licenses = ["MIT"]

  s.files = `git ls-files`.split("\n").reject {|file| file.start_with? "example/"}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md",
    "CHANGELOG.md"
  ]
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency 'bugsnag'

end
