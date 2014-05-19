# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lumiere/version'

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = "lumiere"
  spec.version       = Lumiere::VERSION
  spec.author        = "Karl Entwistle"
  spec.email         = "karl.entwistle@unboxedconsulting.com"
  spec.summary       = %q{Lumiere fetches metadata from video providers}
  spec.description   = %q{Lumiere fetches metadata from video providers}
  spec.homepage      = "https://github.com/karlentwistle/lumiere"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 1.9.3'

  spec.files         = Dir['LICENSE.txt', 'README.rdoc', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "representable", "~> 1.8.2"
  spec.add_dependency "virtus", ">= 0.5.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3.1"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'activesupport'
end
