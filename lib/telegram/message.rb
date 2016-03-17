# frozen_string_literal: true

# Is a representation of Telegrams Message object
class Message
  attr_reader :chat, :text

  def self.from_hash(message)
    return nil unless message.is_a? Hash

    chat = Chat.from_hash message['chat']
    from = User.from_hash message['from']

    Message.new(message_id: message['message_id'], from: from, chat: chat, text: message['text'])
  end

  def initialize(message_id:, from:nil, chat:, text:)
    @message_id = message_id
    @from = from
    @chat = chat
    @text = text
  end

  def contains_command?(command)
    if command.is_a?(Symbol) && text.split(' ').first.eql?("/#{command}")
      true
    elsif text.start_with?(command.to_s)
      true
    else
      false
    end
  end

  def reply(text, opts = {})
    chat.reply text, opts.merge(reply_to_message_id: @message_id)
  end
end
