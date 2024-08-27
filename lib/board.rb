class Board

  def initialize(max_guesses, color_choices)
    @board = []
    @winning_row = []
    @color_choices = color_choices

    create_board_array(max_guesses)
  end

  def display_board(reveal = false)
    @winning_row.each {|item| print(reveal ? item : "❓")}
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
      user_input = player.get_color_choice(@color_choices)
      @winning_row[i] = convert_letter_to_color(user_input)
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

    @board[row].first(4).each_with_index do |item, index|
      # create array with indexes of selected color in winning row
      color_indexes = @winning_row.each_with_index.reduce([]) do |acc, (second_item, second_index)|
        acc.push(second_index) if second_item == item
        acc
      end

      if @winning_row.include?(item) && color_indexes.include?(index)
        @board[row].push("🔴")
      elsif @winning_row.include?(item)
        @board[row].push("⚪️")
      end
    end
  end

  private

  def create_board_array(max_guesses)
    max_guesses.times {@board.push(["⚫️", "⚫️", "⚫️", "⚫️", "|"])}
  end

  def convert_letter_to_color(letter)
    if @color_choices.keys.include?(letter.to_sym)
      @color_choices[letter.to_sym]
    else
      letter
    end
  end
end