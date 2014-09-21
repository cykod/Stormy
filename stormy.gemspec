# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stormy/version'

Gem::Specification.new do |spec|
  spec.name          = "stormy"
  spec.version       = Stormy::VERSION
  spec.authors       = ["Pascal Rettig"]
  spec.email         = ["pascal@cykod.com"]
  spec.summary       = %q{Minimal Static CMS}
  spec.description   = %q{Still Minimal}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "codeclimate-test-reporter"
  

  spec.add_dependency "rack"
  spec.add_dependency "tilt"
  spec.add_dependency "haml"
  spec.add_dependency "kramdown"
  spec.add_dependency "sass"
  spec.add_dependency "activesupport"
end
