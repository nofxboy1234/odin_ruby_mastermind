class CodeBreaker
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def guess(code)
    place_pegs(code)
  end

  private

  def place_pegs(code)
    board.store_guess_pegs(code)
  end
end
