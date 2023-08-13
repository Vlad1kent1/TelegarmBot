class Bot
  def initialize(figure)
    @figure = figure
  end

  def set_figure(new_figure)
    @figure = new_figure
  end

  def current_figure
    @figure
  end

  def random_move(field)
    available_positions = field.values.select { |_, value| value == 0 }.keys
    return nil if available_positions.empty?

    random_position = available_positions.sample
    field[random_position] = @figure
  end

  def check_horizontal(field, fig)
    (0..2).each do |row|
      row_offset = row * 3
      return 3 + row_offset if field[1 + row_offset] == fig && field[2 + row_offset] == fig && field[3 + row_offset] == 0
      return 2 + row_offset if field[1 + row_offset] == fig && field[2 + row_offset] == 0 && field[3 + row_offset] == fig
      return 1 + row_offset if field[1 + row_offset] == 0 && field[2 + row_offset] == fig && field[3 + row_offset] == fig
    end

    false
  end

  def check_vertical(field, fig)
    (1..3).each do |col|
      return col + 6 if field[col] == fig && field[col + 3] == fig && field[col + 6] == 0
      return col + 3 if field[col] == fig && field[col + 3] == 0 && field[col + 6] == fig
      return col if field[col] == 0 && field[col + 3] == fig && field[col + 6] == fig
    end
    
    false
  end

  def check_diagonal1(field, fig)
    return 9 if field[1] == fig && field[5] == fig && field[9] == 0
    return 5 if field[1] == fig && field[5] == 0 && field[9] == fig
    return 1 if field[1] == 0 && field[5] == fig && field[9] == fig

    false
  end

  def check_diagonal2(field, fig)
    return 3 if field[7] == fig && field[5] == fig && field[3] == 0
    return 5 if field[7] == fig && field[5] == 0 && field[3] == fig
    return 7 if field[7] == 0 && field[5] == fig && field[3] == fig

    false
  end

  def try_to_move(field)
    fig = (@figure == 1) ? 2 : 1
    horizontal_result = check_horizontal(field, @figure) || check_horizontal(field, fig)
    vertical_result = check_vertical(field, @figure) || check_vertical(field, fig)
    diagonal1_result = check_diagonal1(field, @figure) || check_diagonal1(field, fig)
    diagonal2_result = check_diagonal2(field, @figure) || check_diagonal2(field, fig)

    if horizontal_result
      field[horizontal_result] = @figure
      return false
    elsif vertical_result
      field[vertical_result] = @figure
      return false
    elsif diagonal1_result
      field[diagonal1_result] = @figure
      return false
    elsif diagonal2_result
      field[diagonal2_result] = @figure
      return false
    end

    return true
  end
end
