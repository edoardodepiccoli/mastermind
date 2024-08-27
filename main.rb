require_relative 'lib/game'

puts("welcome to mastermind")
game = Game.new(AiPlayer, HumanPlayer)