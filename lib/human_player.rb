require_relative 'utils'

class HumanPlayer < Player
  include Utils

  def get_secret_colors(color_choices)
    selected_colors = []

    until selected_colors.size == 4
      system('clear')
      puts('you are the puzzler, choose 4 of these colors')
      color_choices.each { |key, value| puts("#{key} => #{value}") }

      puts("here's your colors: #{selected_colors}") if selected_colors.size > 0
      puts('chose one') if selected_colors.size == 0
      puts('chose another') if selected_colors.size > 0

      user_input = gets.chomp

      until color_choices.keys.include?(user_input.to_sym)
        puts('try again')
        user_input = gets.chomp
      end

      selected_colors.push(color_choices[user_input.to_sym])
    end

    selected_colors
  end

  def get_color_choice(possible_choices)
    puts('choose a color')
    user_input = gets.chomp

    until possible_choices.keys.include?(user_input.to_sym)
      puts('try again')
      user_input = gets.chomp
    end

    user_input
  end
end
