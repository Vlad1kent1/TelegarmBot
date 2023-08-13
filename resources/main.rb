require 'telegram/bot'
require 'dotenv/load'

require_relative 'setup'
require_relative 'start_end'
require_relative 'bot_class'
require_relative 'field_class'

token = '5887340748:AAF9NtoShMPVwUALzuJw9j0jwQPho6zAHcs'
mybot = Bot.new(1)
myfield = Field.new(0)
game_started = false
game_continue = false

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      case message.text
      when '/start'
        start(bot, message)
        game_continue = true
        game_started = true
      when '/help'
        help_message = <<~HELP
          Welcome to the bot!
          Available commands:
          - /start: Start a game
          - /help: Show this help message
          - /stop: Stop a game
        HELP
        bot.api.send_message(chat_id: message.chat.id, text: help_message)      
      when '/stop'
        end_game(bot, message, myfield)
      when '1'..'9'
        if game_continue
          move = message.text.to_i
          game_continue = continue_game(bot, message, myfield, mybot, move)
        else
          bot.api.send_message(chat_id: message.chat.id, text: "I'm sorry, I don't understand that command. Type /help for assistance.")
        end
      else
        bot.api.send_message(chat_id: message.chat.id, text: "I'm sorry, I don't understand that command. Type /help for assistance.")
      end
    when Telegram::Bot::Types::CallbackQuery
      case message.data
      when 'x_button'
        if game_started
          myfield = Field.new(message.message.chat.id)
          set_crosses(bot, message.message, myfield, mybot)
        else
          bot.api.send_message(chat_id: message.message.chat.id, text: "You have chosen the side. To change the side write /start")
        end
        game_started = false
      when 'o_button'
        if game_started
          myfield = Field.new(message.message.chat.id)
          set_noughts(bot, message.message, myfield, mybot)
        else
          bot.api.send_message(chat_id: message.message.chat.id, text: "You have chosen the side. To change the side write /start")
        end
        game_started = false
      end
    end
  end
end
