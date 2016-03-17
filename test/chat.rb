# frozen_string_literal: true

# test chat class
describe Chat do
  it 'can be created using a Hash' do
    hashed_chat = { 'id' => rand(100), 'type' => 'private' }
    chat = Chat.from_hash(hashed_chat)

    assert_equal chat.id, hashed_chat['id']
    assert_equal chat.type, hashed_chat['type']
    assert_nil chat.title
    assert_nil chat.username
    assert_nil chat.first_name
    assert_nil chat.last_name
  end

  it 'can be created using a Hash' do
    hashed_chat = { 'id' => rand(100), 'type' => 'private', 'title' => 'foo', 'username' => 'bar', 'first_name' => 'baz', 'last_name' => 'qux' }
    chat = Chat.from_hash(hashed_chat)

    assert_equal chat.id, hashed_chat['id']
    assert_equal chat.type, hashed_chat['type']
    assert_equal chat.title, hashed_chat['title']
    assert_equal chat.username, hashed_chat['username']
    assert_equal chat.first_name, hashed_chat['first_name']
    assert_equal chat.last_name, hashed_chat['last_name']
  end

  it 'can be created with an initializer' do
    chat = Chat.new(id: rand(100), type: 'private')

    assert !chat.id.nil?
    assert_equal chat.type, 'private'
    assert_nil chat.title
    assert_nil chat.username
    assert_nil chat.first_name
    assert_nil chat.last_name
  end

  it 'can be created with an initializer' do
    chat = Chat.new(id: rand(100), type: 'private', title: 'foo', username: 'bar', first_name: 'baz', last_name: 'qux')

    assert !chat.id.nil?
    assert_equal chat.type, 'private'
    assert_equal chat.title, 'foo'
    assert_equal chat.username, 'bar'
    assert_equal chat.first_name, 'baz'
    assert_equal chat.last_name, 'qux'
  end

  it 'can send replies' do
    chat = Chat.new(id: rand(100), type: 'private')
    text = 'some text'
    Telegram.expects(:sendMessage).with(chat_id: chat.id, text: text)

    chat.reply(text)
  end
end
