# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fist_of_fury/version'

Gem::Specification.new do |gem|
  gem.name          = 'fist_of_fury'
  gem.version       = FistOfFury::VERSION
  gem.authors       = ['Joshua Rieken']
  gem.email         = ['joshua@joshuarieken.com']
  gem.description   = %q{Recurring jobs for Sucker Punch}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/facto/fist_of_fury'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_dependency 'sucker_punch', '~> 1.0.2'
end
