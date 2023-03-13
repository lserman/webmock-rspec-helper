# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webmock-rspec-helper/version'

Gem::Specification.new do |spec|
  spec.name          = 'webmock-rspec-helper'
  spec.version       = WebMock::RSpec::Helper::VERSION
  spec.authors       = ['Logan Serman']
  spec.email         = ['logan.serman@metova.com']
  spec.summary       = 'Easily define WebMock stubs that point to JSON files'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/lserman/webmock-rspec-helper'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0', '< 4.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'rspec'
  spec.add_dependency 'webmock'
  spec.add_dependency 'rails', '>= 3.0.0'
end
