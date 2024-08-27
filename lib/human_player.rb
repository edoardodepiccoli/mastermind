class HumanPlayer < Player
  def get_color_choice
    possible_choices = ["r", "g", "b", "y"]

    puts("choose a color")
    user_input = gets.chomp

    until(possible_choices.include?(user_input))
      puts("try again")
      user_input = gets.chomp
    end

    user_input
  end
end