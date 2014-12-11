# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object_oriented_beaglebone_black/version'

Gem::Specification.new do |spec|
  spec.name          = "object_oriented_beaglebone_black"
  spec.version       = ObjectOrientedBeagleboneBlack::VERSION
  spec.authors       = ["Tadatoshi Takahashi"]
  spec.email         = ["tadatoshi@gmail.com"]
  spec.summary       = %q{For using BeagleBone Black in Object-Oriented way through Ruby.}
  spec.description   = %q{Performs accessing GPIO, etc. in Object-Oriented way on BeagleBone Black through Ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.1.2'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "examples"]

  # spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
