# frozen_string_literal: true

# The Player class is responsible for representing a Player and how
# they create and guess a mastercode
class Player
  attr_reader :board

  def initialize(board)
    @board = board
  end
end
