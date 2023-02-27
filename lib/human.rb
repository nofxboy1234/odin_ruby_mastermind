class Human < Player
  def create_mastercode
    board.store_mastercode_pegs(gets.chomp.strip.downcase)
  end

  def guess_mastercode
    gets.chomp.strip.downcase
  end
end
