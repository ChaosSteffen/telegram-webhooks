# telegram-webhooks
[![Build Status](https://travis-ci.org/ChaosSteffen/telegram-webhooks.svg?branch=master)](https://travis-ci.org/ChaosSteffen/telegram-webhooks)
[![Code Climate](https://codeclimate.com/github/ChaosSteffen/telegram-webhooks/badges/gpa.svg)](https://codeclimate.com/github/ChaosSteffen/telegram-webhooks)
[![Test Coverage](https://codeclimate.com/github/ChaosSteffen/telegram-webhooks/badges/coverage.svg)](https://codeclimate.com/github/ChaosSteffen/telegram-webhooks/coverage)

This project gives you a nice DSL-like interface for the Telegram Bot API using webhooks.

## What is the difference between the Webhooks API and polling?
I recommend you reading Telegrams very good [Bot API documentation](https://core.telegram.org/bots/api) for details.

But tl;dr:  
When using the polling method, you have to build an application that regularly asks the Telegram if there are any new messages.
This approach works very well if you have a low traffic bot and/or are behind a firewall.

When using Webhooks, you register a callback-url at the Telegram API, which is called when new data is available.
But, you need an publicly accessible URL for that, so you can't run that behind a firewall, but you can run it easily using a cloud service like [Heroku](https://www.heroku.com).

## Example
This is a basic example setting up an echo bot. The most simple creature in the Bot Universe.

For a more complex example project see the [TumblrFeedBot](https://github.com/ChaosSteffen/TumblrFeedBot)

The easiest way to try this is using a cloud service like [Heroku](https://www.heroku.com).

### 0. Create a Telegram Bot and get a token
You can create a new Telegram Bot by talking to [@BotFather](https://telegram.me/botfather). More on this you will find in the [Telegram Documentation](https://core.telegram.org/bots#3-how-do-i-create-a-bot).

### 1. You need this gem! Believe me, you will.
Install it by hand, like:
```
gem install telegram-webhooks
```

Or let ```bundler``` do it for you:
```
gem 'telegram-webhooks'
```

### 2. Echo Bots code:
```
# config.ru

require 'telegram'

Telegram.token = ENV['TELEGRAM_TOKEN']

class App < Bot
  on :echo do |update|
    update.message.chat.reply(update.message.text)
  end
end

run App.new
```

### 3. Gentlemen, start your engines!
#### 3a When using Heroku
```
$ heroku config:set TELEGRAM_TOKEN=... 
$ git push heroku master
```

#### 3b When running locally
```
$ TELEGRAM_TOKEN="..." bundle exec rackup
```

### 4. Finally, activate Telegrams webhooks for your App.
In order to activate the Webhooks API you have to send a single POST request against their api specify a url where you want to receive new updates.

Telegram recommends to use your Telegram Token as a part of your URL to [avoid other people tampering with your bot](https://core.telegram.org/bots/api#setwebhook).

```
curl --data "url=https://your.bots.url/YOUR_TELEGRAM_TOKEN_HERE" https://api.telegram.org/botYOUR_TELEGRAM_TOKEN_HERE/setWebhook
```
