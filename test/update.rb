# frozen_string_literal: true

# test Update class
describe Update do
  let(:fake_message) { Message.new(message_id: rand(100), from: nil, chat: nil, text: 'Text Text Text') }

  it 'can be created using a Hash' do
    hashed_update = {
      'update_id' => rand(100_000_000),
      'message' => {
        'message_id' => rand(1000),
        'from' => { 'id' => rand(100_000_000), 'first_name' => 'Foo', 'last_name' => 'Bar', 'username' => 'FooBar' },
        'chat' => { 'id' => rand(100_000_000), 'first_name' => 'Foo', 'last_name' => 'Bar', 'username' => 'Foobar', 'type' => 'private' },
        'date' => rand(100_000_000),
        'text' => 'x'
      }
    }

    update = Update.from_hash(hashed_update)

    assert_equal update.instance_variable_get(:@update_id), hashed_update['update_id']
    assert_equal update.message.text, 'x'
  end

  it 'can be created with an initializer' do
    update_id = rand(100_000_000)
    update = Update.new(update_id: update_id, message: fake_message, inline_query: nil, chosen_inline_result: nil)

    assert_equal update.instance_variable_get(:@update_id), update_id
    assert_equal update.message.text, fake_message.text
  end
end
