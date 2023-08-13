def build_game_field(field)
  str = ' '
  (1..9).each do |i|
    str += case field[i]
           when 0
             "◻️  "
           when 1
             "❎  "
           when 2
             "🅾️  "
           else
             'something went really wrong'
           end
           str += '|  ' if i % 3 != 0

           if i % 3 == 0
             str += "\n"
             str += "➖➕➖➕➖\n" if i != 9
           end
    end
  str
end

def build_keyboard(field)
  keyboard_buttons = []
  row = []

  field.each do |key, value|
    button_text = case value
                  when 1
                    '❎'
                  when 2
                    '🅾️'
                  else
                    key.to_s
                  end

    row << Telegram::Bot::Types::KeyboardButton.new(text: button_text)
    if row.length == 3
      keyboard_buttons << row
      row = []
    end
  end

  keyboard_buttons
end

def show_game_field(bot, message, field)
  buttons = build_keyboard(field)
  markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons)

  mess_map = build_game_field(field)
  bot.api.send_message(chat_id: message.chat.id, text: mess_map, reply_markup: markup)
end

