class CodeMaker < Player
  def create_mastercode(code)
    place_pegs(code)
  end

  private

  def place_pegs(code)
    board.store_code_pegs(code)
  end
end
