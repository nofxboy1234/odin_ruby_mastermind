class Computer < Player
  def choose_mastercode
    # random_code.join
    '2234'
  end

  def guess_mastercode
    Guess.new(board.guess_pegs.last).guess_pegs
  end
end
