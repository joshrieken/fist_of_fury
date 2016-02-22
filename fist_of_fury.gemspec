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
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'ruby_gntp'

  if RUBY_PLATFORM != 'java'
    gem.add_development_dependency 'coveralls'
  end

  gem.add_dependency 'sucker_punch', '~> 2.0.0'
  gem.add_dependency 'celluloid',    '~> 0.17.2'
  gem.add_dependency 'ice_cube',     '~> 0.11.3'
end
