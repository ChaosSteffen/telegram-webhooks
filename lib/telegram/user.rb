# frozen_string_literal: true

# Is a representation of Telegrams user object
class User
  attr_reader :first_name, :last_name, :username

  def self.from_hash(user)
    return nil unless user.is_a? Hash

    User.new(id: user['id'], first_name: user['first_name'], last_name: user['last_name'], username: user['username'])
  end

  def initialize(id:, first_name:, last_name:nil, username:nil)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @username = username
  end
end
