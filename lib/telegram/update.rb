# frozen_string_literal: true

# Is a representation of Telegrams Update object
class Update
  attr_reader :message

  def self.from_hash(update)
    return nil unless update.is_a? Hash

    message = Message.from_hash update['message']

    Update.new(update_id: update['update_id'], message: message)
  end

  def initialize(update_id:, message: nil, inline_query: nil, chosen_inline_result: nil)
    @update_id = update_id
    @message = message
    @inline_query = inline_query
    @chosen_inline_result = chosen_inline_result
  end
end
