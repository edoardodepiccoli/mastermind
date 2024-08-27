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
    @board.display_board
    puts

    play_round
  end

  private

  def play_round 
    # add win check here before everything else
    if @board.won?
      puts("you won!".colorize(:green))
      return
    elsif no_more_turns?
      puts("no more guesses left, you lost!".colorize(:red))
      return
    else
      #turn starts 
      while(@row_turn < 4) do
        # ask for player input
        puts("round number #{@round}")

        user_input = @guesser.get_color_choice
        @board.insert_color(user_input, @round, @row_turn)

        system("clear")
        @board.display_board
        puts

        @row_turn += 1
      end

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
