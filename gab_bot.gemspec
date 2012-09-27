# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gab_bot/version'

Gem::Specification.new do |gem|
  gem.name          = "gab_bot"
  gem.version       = GabBot::VERSION
  gem.authors       = ["Mark Ryall"]
  gem.email         = ["mark@ryall.name"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'cinch'
  gem.add_dependency 'ripl-watir'
  gem.add_development_dependency 'rake'
end
