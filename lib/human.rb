class Human < Player
  def choose_mastercode
    gets.chomp.strip.downcase
  end

  def guess_mastercode
    gets.chomp.strip.downcase
  end
end
