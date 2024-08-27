require_relative 'lib/game'

system("clear")

puts("welcome to mastermind!".colorize(:blue))
puts("do you want to be the guesser or the puzzler? (g/p)")

user_role = gets.chomp

until user_role == "g" || user_role == "p" do
  puts("try again")
  user_role = gets.chomp
end

puzzler_class = user_role == "p" ? HumanPlayer : AiPlayer
guesser_class = user_role == "p" ? AiPlayer : HumanPlayer

game = Game.new(puzzler_class, guesser_class)