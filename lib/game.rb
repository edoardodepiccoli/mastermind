#
# mastermind; player vs computer; 12 turns to guess secret code
# for the entire game the player roles will be the same, next game maybe inverted
#
# first (computer) selects the winning_row of colors
# then display ? ? ? ? and board under it
# ask opposite player for guess
#   highlight placing position, select color, update board, display results when finished
# repeat until no more guesses left
#

require_relative 'board'
require_relative 'player'
require_relative 'ai_player'
require_relative 'human_player'

require 'colorize'

class Game
  @@testing = false

  def initialize(puzzler_class, guesser_class)
    system('clear')

    @color_choices = {
      r: '🔴',
      g: '🟢',
      b: '🔵',
      y: '🟡',
      p: '🟣',
      o: '🟠'
    }

    @max_guesses = 12
    @board = Board.new(@max_guesses, @color_choices)
    @round = 0
    @row_turn = 0

    @puzzler = puzzler_class.new
    @guesser = guesser_class.new

    @board.create_secret_row(@puzzler)

    play_round
  end

  private

  def reset_screen(secret_row_visible = false)
    system('clear')
    puts("these are the colors you can choose\ninserting from left to right, bottom to top")
    @color_choices.each { |key, value| puts("#{key} => #{value}") }
    puts
    @board.display_board(@@testing)
    puts
  end

  def play_round
    if @board.won? # show won and reveal secret
      system('clear')
      puts('game won!'.colorize(:green))
      puts
      @board.display_board(true)
      puts
      nil
    elsif no_more_turns? # show lost and reveal secret
      system('clear')
      puts('no more guesses left, game lost!'.colorize(:red))
      puts
      @board.display_board(true)
      puts
      nil
    else
      reset_screen
      while @row_turn < 4
        puts("round number #{@round}")

        user_input = @guesser.get_color_choice(@color_choices)
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
    return true if @round == @max_guesses

    false
  end
end
