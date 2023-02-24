class Player
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def think(_how_long)
    sleep(1)
  end
end
