class HumanPlayer < Player
  def get_color_choice(possible_choices)

    puts("choose a color")
    user_input = gets.chomp

    until(possible_choices.keys.include?(user_input.to_sym))
      puts("try again")
      user_input = gets.chomp
    end

    user_input
  end
end