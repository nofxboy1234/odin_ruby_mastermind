# frozen_string_literal: true

# The Player class is responsible for being the base class of Human
# and Computer players. It takes the game board as a constructor parameter.
class Player
  attr_reader :board

  def initialize(board)
    @board = board
  end
end
