module Utils
  def convert_letter_to_color(colors, letter)
    if colors.keys.include?(letter.to_sym)
      colors[letter.to_sym]
    else
      letter
    end
  end
end