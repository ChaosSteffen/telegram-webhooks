# frozen_string_literal: true
describe Bot do
  let(:fake_message) { Message.new(message_id: rand(100), chat: nil, text: "/hello is it me you're looking for?") }
  let(:fake_update) { Update.new(update_id: rand(100), message: fake_message) }

  it 'works as a rack app' do
    assert app.respond_to?(:call)
  end

  it 'lets Telegram verify the path' do
    Telegram.expects(:path_verified)

    post '/'
  end

  it 'lets Telegram parse updates' do
    some_json = '{"some":"data"}'
    Telegram.stubs(path_verified: true)
    Telegram.expects(:parse_update).with(some_json)

    post '/', some_json
  end

  it 'remembers commands' do
    class MyBot < Bot; end
    MyBot.class_eval do
      on :foo do |update|
        # nothing
      end
    end

    assert_equal MyBot.commands.keys, [:foo]
    Object.send(:remove_const, 'MyBot')
  end

  it 'executes commands when triggerd by a message' do
    Telegram.stubs(path_verified: true, parse_update: fake_update)

    class MyBot < Bot; end
    MyBot.class_eval do
      on :hello do |_|
        raise 'Call me maybe!'
      end
    end

    replace_app(MyBot.new) do
      exception = assert_raises(RuntimeError) { get '/' }
      assert_equal exception.message, 'Call me maybe!'
    end
    Object.send(:remove_const, 'MyBot')
  end

  it 'hands over the update-object to the commands code' do
    update = fake_update
    Telegram.stubs(path_verified: true, parse_update: update)

    class MyBot < Bot; end
    MyBot.class_eval do
      on :hello do |updte|
        raise updte.message.text
      end
    end

    replace_app(MyBot.new) do
      exception = assert_raises(RuntimeError) { get '/' }
      assert_equal exception.message, update.message.text
    end
    Object.send(:remove_const, 'MyBot')
  end
end
