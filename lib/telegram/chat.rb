# frozen_string_literal: true

# Is a representation of Telegrams Chat object
class Chat
  attr_reader :id, :type, :title, :username, :first_name, :last_name

  def self.from_hash(chat)
    return nil unless chat.is_a? Hash

    Chat.new(id: chat['id'], type: chat['type'], title: chat['title'], username: chat['username'], first_name: chat['first_name'], last_name: chat['last_name'])
  end

  def initialize(id:, type:, title: nil, username: nil, first_name: nil, last_name: nil)
    @id = id
    @type = type
    @title = title
    @username = username
    @first_name = first_name
    @last_name = last_name
  end

  def reply(text, opts = {})
    Telegram.sendMessage opts.merge(chat_id: id, text: text)
  end
end
