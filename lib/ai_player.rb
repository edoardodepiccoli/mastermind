class AiPlayer < Player

  def get_color_choice(available_colors)
    available_colors.keys.sample
  end

end