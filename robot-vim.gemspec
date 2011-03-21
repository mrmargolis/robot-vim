# -*- encoding: utf-8 -*-
require File.expand_path("../lib/robot-vim/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "robot-vim"
  s.version     = Robot::Vim::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Margolis"]
  s.email       = ["matt@mattmargolis.net"]
  s.homepage    = "http://rubygems.org/gems/robot-vim"
  s.summary     = "Vim automation with Ruby"
  s.description = "Invoke Vim from inside of Ruby to allow for TDD/BDD of Vim plugins and scripts"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "robot-vim"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
