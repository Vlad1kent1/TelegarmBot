def start(bot, message)
  kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}", reply_markup: kb)
  choice = [[
    Telegram::Bot::Types::InlineKeyboardButton.new(text: '❎', callback_data: 'x_button'),
    Telegram::Bot::Types::InlineKeyboardButton.new(text: '🅾️', callback_data: 'o_button')
  ]]
  markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: choice)
  bot.api.send_message(chat_id: message.chat.id, text: 'Do you want to play for crosses or noughts?', reply_markup: markup)
end

def end_game(bot, message, field)
  field.clear
  buttons = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  bot.api.send_message(chat_id: message.chat.id, text: "Game is over. To start a new game, type /start.", reply_markup: buttons)
end

