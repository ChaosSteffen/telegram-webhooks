# frozen_string_literal: true

# test Message class
describe Message do
  it 'can be created using a Hash' do
    message_hash = { 'message_id' => rand(100), 'from' => nil, 'chat' => nil, 'text' => 'Text Text Text' }
    message = Message.from_hash(message_hash)

    assert_equal message.instance_variable_get(:@message_id), message_hash['message_id']
    assert_equal message.instance_variable_get(:@from), message_hash['from']
    assert_equal message.chat, message_hash['chat']
    assert_equal message.text, message_hash['text']
  end

  it 'can be created with an initializer' do
    message = Message.new(message_id: rand(100), from: nil, chat: nil, text: 'Text Text Text')

    assert !message.instance_variable_get(:@message_id).nil?
    assert_nil message.instance_variable_get(:@from)
    assert_nil message.chat
    assert_equal message.text, 'Text Text Text'
  end

  it 'can send replies' do
    chat = Chat.new(id: rand(100), type: 'private')
    message_id = rand(100)
    message = Message.new(message_id: message_id, from: nil, chat: chat, text: 'Text Text Text')

    Telegram.expects(:sendMessage).with(chat_id: chat.id, text: 'My Reply', :reply_to_message_id => message_id)

    message.reply('My Reply')
  end

  it 'checks if it contains a command' do
    message = Message.new(message_id: rand(100), from: nil, chat: nil, text: '/work')
    assert message.contains_command?(:work)
  end

  it 'checks if it contains a string' do
    message = Message.new(message_id: rand(100), from: nil, chat: nil, text: 'Hello my friend!')
    assert !message.contains_command?(:hello)
    assert message.contains_command?('Hello')
  end

end
