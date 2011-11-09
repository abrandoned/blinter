# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blinter/version"

Gem::Specification.new do |s|
  s.name        = "blinter"
  s.version     = Blinter::VERSION
  s.authors     = ["Brandon Dewitt"]
  s.email       = ["brandonsdewitt+blinter@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ Write a gem summary}
  s.description = %q{A gem that searches source code for my personal frustrations}

  s.rubyforge_project = "blinter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "thor"
end
