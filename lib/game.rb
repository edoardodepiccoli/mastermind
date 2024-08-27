=begin

mastermind; player vs computer; 12 turns to guess secret code
for the entire game the player roles will be the same, next game maybe inverted

first (computer) selects the winning_row of colors
then display ? ? ? ? and board under it
ask opposite player for guess
  highlight placing position, select color, update board, display results when finished
repeat until no more guesses left

=end

require_relative 'board'
require_relative 'player'
require_relative 'ai_player'
require_relative 'human_player'

require 'colorize'

class Game
  @@testing = false

  def initialize(puzzler_class, guesser_class)
    system("clear")
    puts("welcome to mastermind!".colorize(:blue))
    puts

    @max_guesses = 12
    @board = Board.new(@max_guesses)
    @round = 0
    @row_turn = 0

    @puzzler = puzzler_class.new
    @guesser = guesser_class.new

    @board.create_winning_row(@puzzler)
    @board.display_board(@@testing)
    puts

    play_round
  end

  private

  def reset_screen(winning_row_visible = false)
    system("clear")
      @board.display_board(winning_row_visible)
    puts
  end

  def play_round
    if @board.won?
      system("clear")
      puts("you won!".colorize(:green))
      @board.display_board(true)
      puts
      return
    elsif no_more_turns? # lost
      system("clear")
      puts("no more guesses left, you lost!".colorize(:red))
      @board.display_board(true)
      puts
      return
    else
      while(@row_turn < 4) do
        puts("round number #{@round}")

        user_input = @guesser.get_color_choice
        @board.insert_color(user_input, @round, @row_turn)

        reset_screen(@@testing)

        @row_turn += 1
      end

      @board.give_row_feedback(@round)

      reset_screen(@@testing)

      @round += 1
      @row_turn = 0
      play_round
    end
  end

  def no_more_turns?
    if @round == @max_guesses
      return true
    else
      return false
    end
  end

end
