require_relative 'lib/game'

system('clear')

roles_combinations = {
  'a' => [AiPlayer, HumanPlayer],
  'b' => [HumanPlayer, HumanPlayer],
  'c' => [HumanPlayer, AiPlayer]
}

puts('welcome to mastermind!'.colorize(:blue))
puts('choose how you want to play')
puts('a) ai decides the secret row, you guess')
puts('b) your friend decides the secret row, you guess')
puts('c) you decide the secret row, ai guesses')

user_choice = gets.chomp.downcase

until %w[a b c].include?(user_choice)
  puts('try again')
  user_choice = gets.chomp
end

puzzler_class = roles_combinations[user_choice][0]
guesser_class = roles_combinations[user_choice][1]

Game.new(puzzler_class, guesser_class)
