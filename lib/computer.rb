class Computer < Player
  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    binding.pry
    Guess.new(board.guess_pegs.last).guess_pegs
  end
end
