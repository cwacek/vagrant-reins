# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant/reins/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-reins"
  spec.version       = Vagrant::Reins::VERSION
  spec.authors       = ["Chris Wacek"]
  spec.email         = ["cwacek@gmail.com"]
  spec.summary       = %q{Ruby API for Vagrant}
  spec.description   = %q{Ruby API for Vagrant that parses the machine readable output of the command line tool. Requires Vagrant >1.4}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "childprocess"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
