class CodeMaker
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def create_mastercode(code)
    place_pegs(code)
  end

  private

  def place_pegs(code)
    board.store_code_pegs(code)
  end
end
