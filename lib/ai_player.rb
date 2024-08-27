class AiPlayer < Player

  def get_color_choice
    ["r", "g", "b", "y"].sample
  end

end