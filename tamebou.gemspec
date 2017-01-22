# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tamebou/version'

Gem::Specification.new do |spec|
  spec.name          = "tamebou"
  spec.version       = Tamebou::VERSION
  spec.authors       = ["woshidan"]
  spec.email         = ["bibro.pcg@gmail.com"]

  spec.summary       = %q{simple validation test generator for rails}
  spec.description   = %q{it read single-line `validates` methods and write test code according to templates. the default fomart is prepared for minitest and rspec.}
  spec.homepage      = "https://github.com/woshidan/tamebou"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
