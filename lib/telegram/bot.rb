# frozen_string_literal: true

# Encapsulates the Bot behavior, inherit your app from Bot class
class Bot
  def call(env)
    return [403, {}, []] unless Telegram.path_verified env['PATH_INFO']

    update = Telegram.parse_update(env['rack.input'].read)

    self.class.commands.each do |command, block|
      instance_exec(update, &block) if update.message.contains_command?(command)
    end

    [200, {}, []]
  end

  def self.commands
    @commands ||= {}
  end

  def self.on(command, &block)
    commands[:"#{command}"] = block
  end
end
