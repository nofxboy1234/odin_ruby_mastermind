class Computer < Player
  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    Guess.new(board.last_guess).join
  end
end
