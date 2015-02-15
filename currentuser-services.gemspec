# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: currentuser-services 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "currentuser-services"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["eric-currentuser"]
  s.date = "2015-02-15"
  s.description = "Offsite sign up and sign in forms for Currentuser.io"
  s.email = "TBD"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "CHANGELOG.md",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/controllers/currentuser/services/sessions_controller.rb",
    "config/currentuser-services_public_key.txt",
    "config/routes.rb",
    "currentuser-services.gemspec",
    "lib/currentuser/services.rb",
    "lib/currentuser/services/controllers/authenticates.rb",
    "lib/currentuser/services/engine.rb",
    "test/currentuser/services/authenticates_test.rb",
    "test/currentuser/services/integration_test.rb",
    "test/currentuser/services/sessions_controller_test.rb",
    "test/currentuser/services_test.rb",
    "test/helper.rb",
    "test/test_application/application.rb"
  ]
  s.homepage = "http://www.currentuser.io"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.4"
  s.summary = "Offsite sign up and sign in forms for Currentuser.io"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gem_config>, [">= 0"])
      s.add_runtime_dependency(%q<encrypto_signo>, [">= 0"])
      s.add_runtime_dependency(%q<rails>, ["~> 4.0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
      s.add_development_dependency(%q<minitest-reporters>, [">= 0"])
      s.add_development_dependency(%q<dotenv>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<minitest-rails-capybara>, [">= 0"])
      s.add_development_dependency(%q<capybara-mechanize>, [">= 0"])
      s.add_development_dependency(%q<currentuser-data>, [">= 0"])
    else
      s.add_dependency(%q<gem_config>, [">= 0"])
      s.add_dependency(%q<encrypto_signo>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 4.0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
      s.add_dependency(%q<minitest-reporters>, [">= 0"])
      s.add_dependency(%q<dotenv>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<minitest-rails-capybara>, [">= 0"])
      s.add_dependency(%q<capybara-mechanize>, [">= 0"])
      s.add_dependency(%q<currentuser-data>, [">= 0"])
    end
  else
    s.add_dependency(%q<gem_config>, [">= 0"])
    s.add_dependency(%q<encrypto_signo>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 4.0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
    s.add_dependency(%q<minitest-reporters>, [">= 0"])
    s.add_dependency(%q<dotenv>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<minitest-rails-capybara>, [">= 0"])
    s.add_dependency(%q<capybara-mechanize>, [">= 0"])
    s.add_dependency(%q<currentuser-data>, [">= 0"])
  end
end

