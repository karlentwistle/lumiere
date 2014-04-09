# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lumiere/version'

Gem::Specification.new do |spec|
  spec.name          = "lumiere"
  spec.version       = Lumiere::VERSION
  spec.authors       = ["Karl Entwistle"]
  spec.email         = ["karl.entwistle@unboxedconsulting.com"]
  spec.summary       = %q{lumiere}
  spec.description   = %q{lumiere}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
