require_relative 'utils'

class Board
  include Utils

  def initialize(max_guesses, color_choices)
    @board = []
    @secret_row = []
    @color_choices = color_choices

    create_board_array(max_guesses)
  end

  def display_board(reveal = false)
    @secret_row.each { |item| print(reveal ? item : '❓') }
    print("\n")
    @board.reverse.each do |item|
      item.each do |cell|
        print(cell)
      end
      print("\n")
    end
  end

  def create_secret_row(player)
    player_choices = player.get_secret_colors(@color_choices)
    @secret_row = player_choices
  end

  def insert_color(user_input, row, column)
    @board[row][column] = convert_letter_to_color(@color_choices, user_input)
  end

  def won?
    @board.each do |row|
      return true if row.first(4) == @secret_row
    end
    false
  end

  def give_row_feedback(row)
    points = []

    @board[row].first(4).each_with_index do |item, index|
      # create array with indexes of selected color in winning row
      color_indexes = @secret_row.each_with_index.each_with_object([]) do |(second_item, second_index), acc|
        acc.push(second_index) if second_item == item
      end

      if @secret_row.include?(item) && color_indexes.include?(index)
        # @board[row].push("🔴")
        points.push('🔴')
      elsif @secret_row.include?(item)
        # @board[row].push("⚪️")
        points.push('⚪️')
      end
    end

    @board[row] = @board[row].concat(points.shuffle)
  end

  private

  def create_board_array(max_guesses)
    max_guesses.times { @board.push(['⚫️', '⚫️', '⚫️', '⚫️', '|']) }
  end
end
