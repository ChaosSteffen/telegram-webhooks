# frozen_string_literal: true
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'rack-minitest/json'
require 'rack-minitest/assertions'
require 'mocha/mini_test'

include Rack::Test::Methods
include Rack::Minitest::JSON
include Rack::Minitest::Assertions

def app
  @app ||= Bot.new
end

def replace_app(new_bot, &block)
  old_bot = @app
  @app = new_bot
  yield(block)
  @app = old_bot
end

Dir['./lib/**/*.rb'].each { |file| require file }
Dir['./test/**/*.rb'].each { |file| require file }
