class AiPlayer < Player
  def get_secret_colors(color_choices)
    chosen_colors = []

    4.times do |variable|
      chosen_colors.push(get_color_choice(color_choices))
    end

    chosen_colors
  end

  def get_color_choice(available_colors)
    available_colors.values.sample
  end
end
