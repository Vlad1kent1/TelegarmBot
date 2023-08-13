require_relative 'show'
require_relative 'start_end'
require_relative 'field_class'
require_relative 'bot_class'

def set_crosses(bot, message, field, mybot)
  mybot.set_figure(2)
  bot.api.send_message(chat_id: message.chat.id, text: "Great choice! You will play for crosses.")
  show_game_field(bot, message, field)
end

def set_noughts(bot, message, field, mybot)
  mybot.set_figure(1)
  mybot.random_move(field)
  bot.api.send_message(chat_id: message.chat.id, text: "Great choice! You will play for noughts.")
  show_game_field(bot, message, field)
end

def continue_game (bot, message, field, mybot, move)
  if field[move] == 0
    figure = (mybot.current_figure == 1) ? 2 : 1
    field[move] = figure

    if mybot.try_to_move(field)
      mybot.random_move(field)
    end

    bot.api.send_message(chat_id: message.chat.id, text: "Making move #{message.text}") 
    show_game_field(bot, message, field)
    check_status(bot, message, field, figure)
    
    if field.all_zeros?
      return false
    else
      return true
    end
  else
    bot.api.send_message(chat_id: message.chat.id, text: "This cell is already occupied. Please choose an available cell.")
  end
end

def check_status(bot, message, field, figure)
  winning_combinations = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]             
  ]

  winning_combinations.each do |combo|
    if combo.all? { |position| field[position] == 1 }
      if figure == 1
        bot.api.send_message(chat_id: message.chat.id, text: "Congratulations! You win with crosses (❎)!")
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Crosses (❎) win! You lose!")
      end
      end_game(bot, message, field)
      return
    elsif combo.all? { |position| field[position] == 2 }
      if figure == 2
        bot.api.send_message(chat_id: message.chat.id, text: "Congratulations! You win with noughts (🅾️)!")
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Noughts (🅾️) win! You lose!")
      end
      end_game(bot, message, field)
      return
    end
  end

  if field.all_positions_filled?
    bot.api.send_message(chat_id: message.chat.id, text: "It\'s a draw!")
    end_game(bot, message, field)
    return
  end
end