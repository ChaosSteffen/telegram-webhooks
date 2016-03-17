# frozen_string_literal: true
Gem::Specification.new do |gem|
  gem.name          = 'telegram-webhooks'
  gem.version       = '0.0.1'
  gem.date          = '2016-03-16'
  gem.summary       = 'A DSL-like telegram adapter'
  gem.description   = 'A DSL-like telegram adapter'
  gem.authors       = ['Steffen Schröder']
  gem.email         = 'steffen@schroeder-blog.de'
  gem.homepage      = 'http://rubygems.org/gems/telegram-webhooks'
  gem.license       = 'MIT'

  gem.files         = Dir['./lib/**/*.rb']
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ['lib']

  gem.add_dependency 'rack', '~> 1'
end
