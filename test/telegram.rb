# frozen_string_literal: true
describe Telegram do
  before do
    Telegram.token = 'EXAMPLETOKEN'
  end

  it 'stores a token' do
    assert_equal Telegram.instance_variable_get(:@telegram_token), 'EXAMPLETOKEN'
  end

  it 'verifies the path' do
    assert Telegram.path_verified('/EXAMPLETOKEN')
    assert !Telegram.path_verified('/bar')
  end

  it 'parses the json from the Telegram API and creates a new Update object with it' do
    Update.expects(:from_hash).with('data' => 'here')

    Telegram.parse_update '{"data": "here"}'
  end

  it 'translates method calls into API calls' do
    Net::HTTP.expects(:post_form).with(URI('https://api.telegram.org/botEXAMPLETOKEN/myMethod'), foo: 'bar')
    Telegram.myMethod(foo: 'bar')
  end
end
