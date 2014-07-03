# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beaglebone/black/ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "beaglebone-black-ruby"
  spec.version       = Beaglebone::Black::Ruby::VERSION
  spec.authors       = ["Tadatoshi Takahashi"]
  spec.email         = ["tadatoshi@gmail.com"]
  spec.summary       = %q{Performs accessing GPIO, etc. on BeagleBone Black through Ruby.}
  spec.description   = %q{Performs accessing GPIO, etc. on BeagleBone Black through Ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
