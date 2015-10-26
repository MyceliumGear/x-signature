# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'x-signature/version'

Gem::Specification.new do |spec|
  spec.name          = "x-signature"
  spec.version       = XSignature::VERSION
  spec.authors       = ["AlexanderPavlenko"]
  spec.email         = ["alerticus@gmail.com"]

  spec.summary       = %q{API requests signing and signature validation}
  spec.description   = %q{Allows to create and validate cryptographic signatures on API requests}
  spec.homepage      = "https://github.com/MyceliumGear/x-signature"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'appraisal', ">= 2.1"

  spec.add_dependency 'redis'
end
