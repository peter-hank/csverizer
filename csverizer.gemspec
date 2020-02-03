# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model/csverizer/version'

Gem::Specification.new do |spec|
  spec.name          = 'csverizer'
  spec.version       = ActiveModel::CSVerizer::VERSION
  spec.authors       = ['William Cunningham', 'Peter Hankiewicz']
  spec.email         = ['w.a.cunningham.ii@gmail.com', 'peter.hankiewicz@gmail.com']
  spec.summary       = 'Serialize models as CSV.'
  spec.description   = 'ActiveModel::Serializers style CSV serialization.'
  spec.homepage      = 'https://github.com/peter-hank/csverizer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.2'

  spec.add_dependency 'activemodel', '>= 5.1'
  spec.add_development_dependency 'rails', '>= 5.1'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.3.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.3.0'
  spec.add_development_dependency 'pry'
end
