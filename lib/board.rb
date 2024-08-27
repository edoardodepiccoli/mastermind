class Board

  def initialize(max_guesses)
    @board = []
    @winning_row = []

    create_board_array(max_guesses)
  end

  def display_board
    @winning_row.each {|item| print(item)}
    print("\n")
    @board.reverse.each do |item|
      item.each do |cell|
        print(cell)
      end
      print("\n")
    end
  end

  def create_winning_row(player)
    4.times do |i|
      @winning_row[i] = convert_letter_to_color(player.get_color_choice)
    end
  end

  def insert_color(user_input, row, column)
    @board[row][column] = convert_letter_to_color(user_input)
  end

  def won?
    @board.each do |row|
      return true if row.first(4) == @winning_row
    end
    return false
  end

  def give_row_feedback(row)
    # implement feedback logic
    # for each element in the current row up to the fourth
    # check if color in row present in winning_row
    # if it is then check if it is in the right position, push to the row accordingly
    @board[row].first(4).each_with_index do |cell|
      if @winning_row.include?(cell)
        if @winning_row.index(cell) == @board[row].index(cell)
          @board[row].push("🔴")
        else
          @board[row].push("⚪️")
        end
      end
    end
  end

  private

  def create_board_array(max_guesses)
    max_guesses.times {@board.push(["⚫️", "⚫️", "⚫️", "⚫️", "|"])}
  end

  def convert_letter_to_color(letter)
    case letter
    when "r" then "🔴"
    when "g" then "🟢"
    when "b" then "🔵"
    when "y" then "🟡"
    else letter
    end
  end

  def convert_colors_to_letter(color)
    case color
    when "🔴" then "r"
    when "🟢" then "g"
    when "🔵" then "b"
    when "🟡" then "y"
    else color
    end
  end

end