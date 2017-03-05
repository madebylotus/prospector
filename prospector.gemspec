# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prospector/version'

Gem::Specification.new do |spec|
  spec.name          = "prospector"
  spec.version       = Prospector::VERSION
  spec.authors       = ["Matthew Millsaps-Brewer"]
  spec.email         = ["matt@madebylotus.com"]

  spec.summary       = %q{Prospector provides a simple integration with the Gem Prospector service.}
  spec.description   = %q{Gem Prospector allows your team to stay on top of important updates to gems in your Ruby project.}
  spec.homepage      = "http://www.gemprospector.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|marketing)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 1.8"
  spec.add_dependency "bundler", "~> 1.12"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "webmock", "~> 1.21"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "rspec", "~> 3.5"
end
