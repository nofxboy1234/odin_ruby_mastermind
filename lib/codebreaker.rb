class CodeBreaker < Player
  def guess(code)
    place_pegs(code)
  end

  private

  def place_pegs(code)
    board.store_guess_pegs(code)
  end
end
