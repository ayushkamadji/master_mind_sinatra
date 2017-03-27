class Player
  
  def play
    display_prompt
    return gets.strip
  end

  # View
  def display_prompt
    print "\nEnter four colours with space in between:\n"
  end
end
