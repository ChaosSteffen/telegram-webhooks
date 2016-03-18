# frozen_string_literal: true
Gem::Specification.new do |gem|
  gem.name          = 'telegram-webhooks'
  gem.version       = '0.1.1'
  gem.date          = '2016-03-18'
  gem.summary       = 'A DSL-like interface for the Telegram messengers Bot API'
  gem.description   = 'This project gives you a nice DSL-like interface for the Telegram Bot API'
  gem.authors       = ['Steffen Schröder']
  gem.email         = 'steffen@schroeder-blog.de'
  gem.homepage      = 'https://github.com/ChaosSteffen/telegram-webhooks'
  gem.license       = 'MIT'

  gem.files         = Dir['./lib/**/*.rb']
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ['lib']

  gem.add_dependency 'rack', '~> 1.6.4'
end
