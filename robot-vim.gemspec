# -*- encoding: utf-8 -*-
require File.expand_path("../lib/robot-vim/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "robot-vim"
  s.version     = Robot::Vim::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Margolis"]
  s.email       = ["matt@mattmargolis.net"]
  s.homepage    = "https://github.com/mrmargolis/robot-vim"
  s.summary     = "Vim automation with Ruby"
  s.description = "Automate Vim with Ruby to allow for TDD/BDD of Vim plugins and scripts"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "robot-vim"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.5.0"
  s.add_development_dependency "autotest"

  s.add_dependency "uuid", "~> 2.3.1"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
