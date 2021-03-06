# frozen_string_literal: true
require 'net/http'
require 'json'

require_relative 'telegram/bot'
require_relative 'telegram/chat'
require_relative 'telegram/message'
require_relative 'telegram/update'
require_relative 'telegram/user'

# Is a representation of Telegram API
module Telegram
  @telegram_token = ''

  def self.token=(telegram_token)
    @telegram_token = telegram_token
  end

  def self.method_missing(method_name, *args, &_block)
    uri = URI("https://api.telegram.org/bot#{@telegram_token}/#{method_name}")
    Net::HTTP.post_form(uri, args.first)
  end

  def self.path_verified(path)
    path.start_with? "/#{@telegram_token}"
  end

  def self.parse_update(raw_update)
    Update.from_hash JSON.parse(raw_update)
  end
end
