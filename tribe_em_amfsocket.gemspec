# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tribe_em_amfsocket/version'

Gem::Specification.new do |gem|
  gem.name          = 'tribe_em_amfsocket'
  gem.version       = Tribe::EM::AmfSocket::VERSION
  gem.authors       = ['Chad Remesch']
  gem.email         = ['chad@remesch.com']
  gem.description   = %q{Amf Socket Ruby wrapper for Tribe EM.}
  gem.summary       = %q{Add Amf Socket functionaly on top of Tribe EM.}
  gem.homepage      = 'https://github.com/chadrem/tribe_em_amfsocket'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency('tribe_em', '~> 0.4')
  gem.add_dependency('amf_socket', '~> 0.3')
end
